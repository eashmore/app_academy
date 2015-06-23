class UsersController < ApplicationController
  before_action :redirect_current_user!, only: [:create, :new]

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

    render :show
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :password)
    end
end
