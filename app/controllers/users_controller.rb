class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to users_path
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end

    redirect_to root_path
  end

  # def current
  #   @current_user = User.find_by(id: session[:user_id])
  #   unless @current_user
  #     flash[:error] = "You must be logged in to see this page"
  #     redirect_to root_path
  #   end
  # end
  # I think just copypastad from TC but not needed

  def logout
    flash[:success] = "Successfully logged out"
    session[:user_id] = nil
    redirect_to root_path
  end
end
