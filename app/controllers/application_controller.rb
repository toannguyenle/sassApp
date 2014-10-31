class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Memoization - only read the first time - look it up ||=
  # Make the current_user available in ALL VIEW TEMPLATES!
  helper_method :current_user

  # Make available in ALL CONTROLLERS
  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end
end