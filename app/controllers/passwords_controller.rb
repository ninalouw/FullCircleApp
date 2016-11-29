class PasswordsController < ApplicationController
  def new
    email = params[:email]
    if email.present?
      render :forgot_password
    else
      render :new
    end
  end

  def index
  end

  def edit
    @password = params.dig(:user, :password)
    @user = current_user
  end

  def update
    @user = User.find current_user
    current_password = params.dig(:user, :current_password)
    if @user && @user.authenticate(current_password)
      if @user.update user_params
        redirect_to root_path, notice: 'Password has been updated!'
      else
        flash.now[:alert] = 'Failed to update your password!'
        render :edit
      end
    else
      flash.now[:alert] = 'Wrong password!'
      render :edit
    end
  end

  # This is going to show them the edit
  def forgot_password
    # verify user
    @user = User.find_by(email: params[:email], token: params[:token])
    if @user
      render
    else
      redirect_to root_path, alert: 'Wrong credentials!'
    end
  end


  def update_password
    @email = params.dig(:user, :email)
    @user = User.find_by(email: @email)
    if @user.update user_params
      redirect_to root_path, notice: 'Password has been updated!'
    else
      flash.now[:alert] = 'Failed to update your password!'
      render :forgot_password
    end
  end

  def link
    @user = User.find_by(email: params[:email])
    if @user
      @user.update(token: rand(1000))
    else
      redirect_to root_path, alert: 'Go away, wrong credentials!'
    end
  end

  def user_params
    params.require(:user).permit([:first_name,
                                                :last_name,
                                                :email,
                                                :password,
                                                :password_confirmation])
  end
end
