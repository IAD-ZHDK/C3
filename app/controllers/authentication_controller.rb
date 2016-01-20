class AuthenticationController < ApplicationController
  def authenticate
    user = User.find_or_create_by!(email: params[:email])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path
  end
end
