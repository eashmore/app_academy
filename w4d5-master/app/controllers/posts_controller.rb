class PostsController < ApplicationController
  before_action :is_author?, only: [:edit, :update]

  def new
    @post = Post.new
    @sub = Sub.find(params[:sub_id])
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = Sub.find(params[:sub_id]).id
    @post.sub_ids = params[:post][:sub_id]
    # fail

    if @post.save
      redirect_to @post.sub
    else
    fail
      redirect_to :back
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post.sub
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def is_author?
    @post = Post.find(params[:id])
    redirect_to @post.sub if current_user.id != @post.author_id
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids)
  end
end
