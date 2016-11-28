class CallbacksController < ApplicationController
  def twitter
  #step1 search for user with the given provider/uid
    twitter_data = request.env['omniauth.auth']
    user = User.find_from_oauth(twitter_data)

  #step2 create the user if the user is not found
    user ||= User.create_from_oauth(twitter_data)

  #step 3 sign in the user
    session[:user_id] = user.id

    redirect_to root_path, notice: "Thanks for signing in with Twitter!"

  #render json: request.env['omniauth.auth']
  end
end
