class UsersController < ApplicationController
  before_action :check_signin, only: [:show, :edit, :index, :update, :destroy]
  before_action :get_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /users
  # GET /users.json
  def index
  	@users = User.order(sort_column + " " + sort_direction)
  	if params[:find_user] != "" 	  
	  @users = @users.where("user_name like ?", "%#{params[:find_user]}%")
	end  	
  	@friends = Friend.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if session[:login_name].to_s != params[:id].to_s
      if @auth != "admin"
        redirect_to users_path, notice: "You cannot perform that action"
      end
    end
  	@users = User.all
  	@friends = Friend.all
  end

  # GET /users/new
  def new
    @users = User.all
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if session[:login_name].to_s != params[:id].to_s
      if @auth != "admin"
        redirect_to users_path, notice: "You cannot perform that action"
      end
    end
  	@users = User.all
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.create!(user_params)
    
    respond_to do |format|
      if @user.save
      	@friends_recipients = params[:friend_recipients]
      	if (!@friends_recipients.nil?)
      	  @friends_recipients.each do |friend|
		  	check_friend(@user.id, friend)
      	  end
      	end
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
      	@friends_recipients = params[:friend_recipients]
      	@delete_friends = Friend.all.where(friend_creator: @user.id)
      	Friend.delete(@delete_friends)
      	if (!@friends_recipients.nil?)
      	  @friends_recipients.each do |friend|
      	    check_friend(@user.id, friend)
      	  end
      	end
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @auth != "admin"
      redirect_to users_path, notice: "You cannot perform that action"
    else
      adminCount = User.where(user_role: "admin").count
      if adminCount == 1
        redirect_to users_path, notice: "Deletion of this account would mean removal of all administrators"
      else
        @user.destroy
        respond_to do |format|
          format.html { redirect_to users_url }
          format.json { head :no_content }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_name, :user_email, :password, :password_confirmation, :user_role)
    end
    
    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "user_name"
    end
  	
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    
    #check if a friend is actually the user
    def check_friend(friendor, friendee)
	  if (friendor != friendee)
      	@thisfriend = Friend.create!({:friend_creator => friendor, :friend_recipient => friendee})
      	@thisfriend.save
      end
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
