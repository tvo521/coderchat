class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(session_params[:email])

    if @user.try(:authenticate, session_params[:password])
      session[:user_id] = @user.id
      redirect_to users_path
    else
      flash[:error] = 'Email or password is incorrect.'
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logout successfully.'
    redirect_to root_path
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
