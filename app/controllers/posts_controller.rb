class PostsController < ApplicationController
  def index
    @posts = Post.published.page(params[:page])
  end

  def show
    @post = Post.get_by_url(params[:id])
  end


end
