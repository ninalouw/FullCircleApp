class Api::V1::GoalsController < Api::BaseController
  def create
    new_goal_params = params.require(:goal).permit(:name, :minutes)
    goal = Goal.new new_goal_params
    goal.user = User.first
    if goal.save
      render json: { id: goal.id, status: :success }
    else
      render json: { status: :failure, errors: goal.errors.full_messages }
    end
  end

  def show
    goal = Goal.find params[:id]
    render json: @goal
  end

  def index
    @goals = Goal.order(created_at: :desc)
    render json: @goals
  end

  def goals_list
    # @goals = User.first.goals.order(count_consecutive_days_completed: :desc)
    @goals = User.first.goals.order(created_at: :desc)
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

    if @goal&.latest_date_completed&.to_date != today
      @goal.update(
      latest_date_completed: today,                                            count_consecutive_days_completed: current_days)
    else
      render json: @goal
    end
    head :ok
  end

  def delete_goal
    @goal = Goal.find params[:id]
    @goal.destroy
    render json: @goal
  end

  def update_edited_goal
    @goal = Goal.find params[:id]
    if @goal.update goal_params
      flash[:notice] = 'Goal updated'
      render json: @goal
    else
      flash.now[:alert] = 'Please see errors below!'
    end
  end

  def goal_params
    params.require(:goal).permit([:name,
                                  :minutes,
                                  :count_consecutive_days_completed,
                                  :latest_date_completed])
  end

end
