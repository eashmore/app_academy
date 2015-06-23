class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    login(@user)
    redirect_to subs_url
  end

  def destroy
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
