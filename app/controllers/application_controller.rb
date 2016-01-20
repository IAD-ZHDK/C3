class ApplicationController < ActionController::Base
  include AuthenticationHelper

  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to login_path unless logged_in?
  end
end
