class Api::BaseController < ApplicationController
  # we are commenting this out temporarily for use with frontend client
  # before_action :authenticate

  def current_user
    @current_user ||= User.find(session[:user_id]) if user_signed_in?
  end
  helper_method :current_user

  # def current_days
  #   # current_days = @goal.count_consecutive_days_completed
  #   # current_days = current_days + 1
  #   
  # end

  private

  def authenticate
    # for authentication with react frontend client add:
    api_key = params[:api_key] || request.headers['Authorization']
    @api_user = User.find_by api_key: params[:api_key]
    # render json: {status: 'invalid api key'} unless user
    head :unauthorized unless @api_user
  end
end
