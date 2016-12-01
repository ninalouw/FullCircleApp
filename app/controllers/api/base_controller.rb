class Api::BaseController < ApplicationController
  # we are commenting this out temporarily for use with frontend client
  # before_action :authenticate

  private

  def authenticate
   # for authentication with react frontend client add:
    api_key = params[:api_key] || request.headers["Authorization"]
    @api_user = User.find_by_api_key params[:api_key]
  # render json: {status: 'invalid api key'} unless user
    head :unauthorized unless @api_user
  end

end
