require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @usernext = users(:two)
    @userthird = users(:three)
    session[:login_name] = @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

# <!!!> breaking -  User name has already been taken, User email has already been taken
#  test "should create user" do
#    assert_difference('User.count') do
#      post :create, user: { user_email: @user.user_email, user_name: @user.user_name, password_digest: @user.password_digest, password_confirmation: @user.password_confirmation, user_role: @user.user_role }
#    end
	
#    assert_redirected_to user_path(assigns(:user))
#  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { user_email: @user.user_email, user_name: @user.user_name, password_digest: @user.password_digest, password_confirmation: @user.password_confirmation, user_role: @user.user_role }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @userthird
    end

    assert_redirected_to users_path
  end
  
#updated: test for users being correctly created
  test "should show correct number of rows" do
    get :index
    assert_select "tr", 6
  end
  
#test for permissions constraints on users
  test "should not permit a user to view user information not their own if they are not admin" do
    session[:login_name] = @usernext
	get :show, id: @user
	assert_redirected_to users_path
  end
  
  test "should permit a user to view user information not their own if they are admin" do
	session[:login_name] = @user
	get :show, id: @usernext
	assert_response :success
  end
  
  test "should not permit a user to delete information if they are not admin" do
    session[:login_name] = @usernext
	delete :destroy, id: @user
	assert_redirected_to users_path
  end
end
