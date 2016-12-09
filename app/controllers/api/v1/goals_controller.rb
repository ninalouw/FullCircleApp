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
    today = Date.today
    @goal = Goal.find params[:id]
    current_days = @goal.count_consecutive_days_completed

    if current_days.blank?
      current_days = 1
    else
      current_days += 1
    end

    if @goal.latest_date_completed.blank?
      @goal.update(latest_date_completed: today, count_consecutive_days_completed: current_days)
    elsif @goal.latest_date_completed.to_date == today
      render json: @goal
    end
    head :ok
    # render json: { notice: 'You have already updated your goal!' }
    # format.js { render js: 'alert("You cannot re-update your goal!");' }
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
      # redirect_to goal_path(@goal) -- this is a get, to get newly edited goal and render it
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
