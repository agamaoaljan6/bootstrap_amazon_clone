class ApplicationController < ActionController::Base
# shared functionally accross multiple controller 
# all the methods that are present here can be used/called on other controllers 

private
  def current_user 
    if session[:user_id].present?
    @current_user ||= User.find_by(id: session[:user_id])
    end
  end

helper_method(:current_user)
# 'helper_method' makes a controller method available to all views (or templates)

def user_signed_in?
    current_user.present?
end
helper_method :user_sign_in?

def authenticate_user!
unless user_signed_in?
    flash[:danger] = "You must sign in or sign up first!"
    redirect_to new_session_path
end
end 

end
