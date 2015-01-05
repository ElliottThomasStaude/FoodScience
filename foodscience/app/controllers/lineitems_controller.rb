class LineitemsController < ApplicationController
  before_action :check_signin
  before_action :set_lineitem, only: [:show, :edit, :update, :destroy]

  # GET /lineitems
  # GET /lineitems.json
  def index
    @lineitems = Lineitem.all
  end

  # GET /lineitems/1
  # GET /lineitems/1.json
  def show
  end

  # GET /lineitems/new
  def new
    @lineitem = Lineitem.new
  end

  # GET /lineitems/1/edit
  def edit
  	@participants = Participant.all
	@users = User.all
  end

  # POST /lineitems
  # POST /lineitems.json
  def create
    respond_to do |format|
      @lineitem = Lineitem.create!(lineitem_params)
      @participants = Participant.all
	  @users = User.all
      if @lineitem.save
        format.html { redirect_to @lineitem, notice: 'Lineitem was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lineitem }
      else
        format.html { render action: 'new' }
        format.json { render json: @lineitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lineitems/1
  # PATCH/PUT /lineitems/1.json
  def update
    respond_to do |format|
      @participants = Participant.all
      @users = User.all
      if @lineitem.update(lineitem_params)
        format.html { redirect_to @lineitem, notice: 'Lineitem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lineitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lineitems/1
  # DELETE /lineitems/1.json
  def destroy
    @lineitem.destroy
    respond_to do |format|
      format.html { redirect_to lineitems_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lineitem
      @lineitem = Lineitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lineitem_params
      params.require(:lineitem).permit(:line_part, :line_order, :line_name, :line_price, :line_notes)
    end
    
    #check user's login status
    def check_signin
      if session[:login_name] == nil
    	redirect_to sessions_url, notice: 'Sign in, please'
      end
    end
    
    #check user's authorization
    def get_admin
      auth = User.where(id: session[:login_name]).first.user_role
    end
end
