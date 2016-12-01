class Api::V1::GoalsController < Api::BaseController
# protect_from_forgery with: :null_session

  def create
    goal_params = params.require(:goal).permit([:name,
                                                :minutes,
                                                :count_consecutive_days_completed,
                                                :latest_date_completed])
    goal = Goal.new goal_params
    goal.user = @api_user
    if goal.save
      render json: { id: goal.id, status: :success }
    else
      render json: { status: :failure, errors: goal.errors.full_messages }
    end
  end


  def show
    goal = Goal.find params[:id]
    render json: goal
  end

  # def goals_list
  #   @goals = current_user.goals
  # end

# for now we will do this, later,
# we will find the user by api key
  def goals_list
    @goals = @user.goals
  end

end
