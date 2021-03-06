class RestaurantsController < ApplicationController
  before_action :check_signin
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.order(sort_column + " " + sort_direction)
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.create!(restaurant_params)

    respond_to do |format|
      if !(@restaurant.rest_menufile.nil?)
		upload
	  end
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @restaurant }
      else
        format.html { render action: 'new' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
    
      if !(@restaurant.rest_menufile.nil?)
        upload
      end
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:rest_name, :rest_phone, :rest_url, :rest_fax, :rest_firstaddr, :rest_secondaddr, :rest_city, :rest_state, :rest_zip, :rest_cuisine, :rest_delivers, :rest_fee, :rest_menufile, :rest_desc)
    end
    
    def sort_column
      Restaurant.column_names.include?(params[:sort]) ? params[:sort] : "rest_name"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    
    def upload
	  uploadfile = params[:restaurant][:rest_menufile]
	  if !(uploadfile.nil?)
	    File.open(Rails.root.join('public/MenuFolder', uploadfile.original_filename), 'wb') do |file|
		  file.write(uploadfile.read)
	    end
	  params[:restaurant][:rest_menufile] = uploadfile.original_filename
	  end
	end
	
	#check user's login status
	def check_signin
      if session[:login_name] == nil
    	redirect_to sessions_url, notice: 'Sign in, please'
      end
    end
end
