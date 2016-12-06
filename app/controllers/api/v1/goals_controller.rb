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
    today = DateTime.now.to_date
    @goal = Goal.find params[:id]
    current_days = @goal.count_consecutive_days_completed

    if current_days.blank?
      current_days = 1
    else
      current_days += 1
    end

    if @goal.latest_date_completed.to_date != today
      @goal.update(latest_date_completed: today, count_consecutive_days_completed: current_days)
      render json: @goal
    end
    head :ok
    # render json: { notice: 'You have already updated your goal!' }
    # format.js { render js: 'alert("You cannot re-update your goal!");' }
  end

  def goal_params
    params.require(:goal).permit([:name,
                                  :minutes,
                                  :count_consecutive_days_completed,
                                  :latest_date_completed])
  end

end
