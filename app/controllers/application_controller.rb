class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    nil || User.find_by_id(session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to access this section.'
      redirect_to new_session_path
    end
  end
end
