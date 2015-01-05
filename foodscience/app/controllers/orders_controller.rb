class OrdersController < ApplicationController
  before_action :check_signin
  before_action :get_admin
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.order(sort_column + " " + sort_direction)
	@users = User.order(:user_name)
    @restaurants = Restaurant.order(:rest_name)
    @participants = Participant.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if (Participant.where(part_order: @order.id, part_user: session[:login_name]).count == 0 && @auth != "admin")
      redirect_to orders_url, notice: "You cannot view that order"
    else
  	  @users = User.order(:user_name)
      @restaurants = Restaurant.order(:rest_name)
      @participants = Participant.all
      @lineitems = Lineitem.all
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    @users = User.order(:user_name)
    @restaurants = Restaurant.order(:rest_name)
  end

  # GET /orders/1/edit
  def edit
    if (@order.order_organizer != session[:login_name] && @auth != "admin")
      redirect_to orders_url, notice: "You cannot edit that order"
    else
  	  @users = User.order(:user_name)
      @restaurants = Restaurant.order(:rest_name)
      @participants = Participant.all
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.create!(order_params)
	@users = User.order(:user_name)
    @restaurants = Restaurant.order(:rest_name)
    
    respond_to do |format|
      if @order.save
      	@thispart = Participant.create!({:part_user => @order.order_organizer, :part_order => @order.id, :part_role => "organizer", :part_cost => 0.00})
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        @users = User.order(:user_name)
        @restaurants = Restaurant.order(:rest_name)
        @parts = params[:part_ids]
      	if !(@parts.nil?)
      	  @parts.each do |part|
		  	if (part != @order.order_organizer)
			  @thispart = Participant.create!({:part_user => part, :part_order => @order.id, :part_role => "participant", :part_cost => 0.00})
      	    end
      	  end
      	end
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if (@order.order_organizer != session[:login_name] && @auth != "admin")
      redirect_to orders_url, notice: "You cannot edit that order"
    else
      @order.destroy
      respond_to do |format|
        format.html { redirect_to orders_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_rest, :order_organizer, :order_type, :order_cost, :order_time_at, :order_status)
    end
    
    def sort_column
      Order.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    
    #check user's login status
    def check_signin
      if session[:login_name] == nil
    	redirect_to sessions_url, notice: 'Sign in, please'
      end
    end
    
    #check user's authorization
    def get_admin
      @auth = User.where(id: session[:login_name]).first.user_role
    end
end
