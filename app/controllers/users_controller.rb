class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :login]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user
      if @user.try(:authenticate, params[:password])
        session[:user_id] = @user.id
        redirect_to :index
      else
        redirect_to root_path
      end
    else
      @user = User.new(user_params)
      if @user.save!
        session[:user_id] = @user.id
        redirect_to :index
      else
        render :new
      end
    end
  end

  def login
  end

  def logout
    session[:user_id] = nil
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
