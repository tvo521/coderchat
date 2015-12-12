class UsersController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @users = User.where('id NOT IN (?)', current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to action: 'index'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
