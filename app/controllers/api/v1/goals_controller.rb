class Api::V1::GoalsController < Api::BaseController


  def create
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

  # for now we will do this, later,
  # we will find the user by api key
  def goals_list
    @goals = User.first.goals
    render json: @goals
  end

  def update_done
    @goal = Goal.find params[:id]
    current_days = @goal.count_consecutive_days_completed
    current_days = current_days + 1
    @goal.update({count_consecutive_days_completed: current_days},
                  {latest_date_completed: Date.today}
                  )
    @goal.save
    render json: @goal
  end

  def goal_params
    params.require(:goal).permit([:name,
                                  :minutes,
                                  :count_consecutive_days_completed,
                                  :latest_date_completed])
  end

end
