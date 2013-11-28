class PostsController < ApplicationController
  def index
    render json: Post.all
  end

  def show
    render json: Post.find(params[:id])
  end

  def create
    post = Post.create post_params
    render json: (post.errors.blank? ? post : { errors: post.errors })
  end

  def update
    post = Post.find params[:id]
    post.update post_params
    render json: post
  end

  private

  def post_params
    params
      .require(:post)
      .permit(:title, :content)
  end
end
