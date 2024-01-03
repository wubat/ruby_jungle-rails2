# app/helpers/sessions_helper.rb
module SessionsHelper
  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end

