class SessionsController < ApplicationController

  def new
    if session[:login_name] != nil
      redirect_to homes_url, notice: 'Welcome, ' + User.where(id: session[:login_name]).first.user_name
    end
  end

  # POST /sessions
  # POST /sessions.json
  def create
  	foundUser = User.where(:user_name => params[:login_name].to_s).first
  	if foundUser and foundUser.authenticate(params[:login_password])
	  session[:login_name] = foundUser.id
	  auth = foundUser.user_role
	  redirect_to homes_url, notice: 'Welcome, ' + params[:login_name]
  	else
  	  redirect_to sessions_url, notice: 'Incorrect password, ' + params[:login_name]
  	end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    auth = nil
	session[:login_name] = nil
    redirect_to sessions_url
  end
end
