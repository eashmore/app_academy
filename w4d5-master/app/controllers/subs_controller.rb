class SubsController < ApplicationController
  before_action :is_moderator?, only: [:edit, :update]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id

    if @sub.save
      redirect_to subs_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.post_post + @sub.posts
  end

  private

  def is_moderator?
    @sub = Sub.find(params[:id])
    redirect_to subs_url if current_user.id != @sub.user_id
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
