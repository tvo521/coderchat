class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :login]

  def index
    @messages = current_user.messages
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(user_params[:email])

    if @user
      if @user.try(:authenticate, user_params[:password])
        session[:user_id] = @user.id
        redirect_to action: 'index'
      else
        redirect_to root_url
      end
    else
      @user = User.new(user_params)
      if @user.save!
        session[:user_id] = @user.id
        redirect_to action: 'index'
      else
        render :new
      end
    end
  end

  def login
    @user = User.new
  end

  def logout
    session[:user_id] = nil
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
