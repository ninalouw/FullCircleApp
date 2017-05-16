class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:email].downcase
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Signed In'
    else
      flash.now[:alert] = 'Wrong credentials'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out!'
  end

  # for jwt implementation
# skip_before_action :authenticate
#
# def create
#   user = User.find_by(email: auth_params[:email])
#   if user.authenticate(auth_params[:password])
#     jwt = Auth.issue({user: user.id})
#     render json: {jwt: jwt}
#   else
#   end
# end
#
# private
#   def auth_params
#     params.require(:auth).permit(:email, :password)
#   end

end
