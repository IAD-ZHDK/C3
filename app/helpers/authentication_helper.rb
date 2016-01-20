module AuthenticationHelper
  def logged_in?
    current_user.present?
  end

  def current_user
    return nil if session[:user_id].blank?
    @current_user ||= User.find(session[:user_id])
  end

  def role?(role)
    return false unless current_user.present?
    current_user.role == role
  end

  def student?
    role?(User::ROLE_STUDENT) || role?(User::ROLE_STAFF) || role?(User::ROLE_ADMIN)
  end

  def staff?
    role?(User::ROLE_STAFF) || role?(User::ROLE_ADMIN)
  end

  def admin?
    role?(User::ROLE_ADMIN)
  end
end
