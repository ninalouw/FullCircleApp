class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user
    redirect_to new_session_path, alert: 'Please sign in' unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if user_signed_in?
  end
  helper_method :current_user

  # from jwt tutorial
  # before_action :authenticate
  #
  # def logged_in?
  #   !!current_user
  # end
  #
  # def current_user
  #   if auth_present?
  #     user = User.find(auth["user"])
  #     if user
  #       @current_user ||= user
  #     end
  #   end
  # end
  #
  # def authenticate
  #   render json: {error: "unauthorized"}, status: 401 unless logged_in?
  # end
  #
  #   private
  #   def token
  #     request.env["HTTP_AUTHORIZATION"].scan(/Bearer
  #       (.*)$/).flatten.last
  #   end
  #
  #   def auth
  #     Auth.decode(token)
  #   end
  #
  #   def auth_present?
  #     !!request.env.fetch("HTTP_AUTHORIZATION",
  #       "").scan(/Bearer/).flatten.first
  #   end
end
