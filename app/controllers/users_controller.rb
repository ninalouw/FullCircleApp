class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit([:first_name,
                                                :last_name,
                                                :email,
                                                :password,
                                                :password_confirmation])
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Thank you for signing up'
    else
      render :new
    end
  end

  def goals_list
    @goals = current_user.goals
    respond_to do |format|
      format.html { render }
      format.text { render }
      format.xml  { render xml: @goal }
      format.json { render json: @goal.to_json }
    end
  end
end
