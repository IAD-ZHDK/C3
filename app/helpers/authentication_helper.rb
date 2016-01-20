module AuthenticationHelper
  def current_user
    return nil if session[:user_id].blank?
    @current_user ||= User.find(session[:user_id])
  rescue Mongoid::Errors::DocumentNotFound
    @current_user = nil
  end

  def logged_in?
    current_user.present?
  end

  def admin?
    current_user.try(:admin?)
  end
end
