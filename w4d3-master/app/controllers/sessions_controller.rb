class SessionsController < ApplicationController
  before_action :redirect_current_user!, only: [:create, :new]

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.find_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if @user.nil?
      @user = User.new
      render :new
    else
      @user.reset_session_token!
      login!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
