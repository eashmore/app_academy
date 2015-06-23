class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    @goal.completed = "Incomplete"
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to :back
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    # if @goal.completed == 'Incomplete' && goal_params[:completed]["Complete"]
    #   @goal.completed = "Complete"
    #   @goal.save
    # end
    # fail
    if @goal.update(goal_params)
      # fail
      redirect_to @goal.user
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to edit_goal_url
    end
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :body, :private_or_public, :completed)
  end
end
