class GoalsController < ApplicationController
  before_action :find_goal, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new goal_params
    @goal.user = current_user
    if @goal.save
      flash[:notice] = 'Goal Created'
      redirect_to goal_path(@goal)
    else
      flash.now[:alert] = 'Please see errors below'
      render :new
    end
  end

  def index
    @goals = Goal.order(created_at: :desc)
    respond_to do |format|
      format.html { render }
      format.text { render }
      format.xml  { render xml: @goal }
      format.json { render json: @goal.to_json }
    end
  end

  def edit; end

  def update
    if @goal.update goal_params
      flash[:notice] = 'Goal updated'
      redirect_to goal_path(@goal)
    else
      flash.now[:alert] = 'Please see errors below!'
      render :edit
    end
  end

  def show
    respond_to do |format|
      format.html { render }
      format.text { render }
      format.xml  { render xml: @goal }
      format.json { render json: @goal.to_json }
    end
  end

  def destroy
    @goal.destroy
    redirect_to goals_list_users_path, notice: 'Goal Deleted'
  end

  private

  def goal_params
    params.require(:goal).permit([:name,
                                  :minutes,
                                  :count_consecutive_days_completed,
                                  :latest_date_completed])
  end

  def find_goal
    @goal = Goal.find params[:id]
  end
end
