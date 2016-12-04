class Api::V1::GoalsController < Api::BaseController
  protect_from_forgery with: :null_session

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
    # first line not working, it is not getting the goal id
    # but setting it to nil
    # but second part is working
    Goal.increment_counter(:count_consecutive_days_completed, :id)
    @goal = Goal.find params[:id]
    @goal.update(latest_date_completed: Time.zone.now)
    render json: @goal
  end

  def goal_params
    params.require(:goal).permit([:name,
                                  :minutes,
                                  :count_consecutive_days_completed,
                                  :latest_date_completed])
  end

end
