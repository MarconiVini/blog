class Admin::PostsController < Admin::BaseAdminController
  def index
    @posts = Post.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    if @post.save
      flash[:notice] = "Post criado com sucesso"
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = "Post editado com sucesso!"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.disabled = post.disabled == false
    post.save

    flash[:notice] = "Post foi deletado"
    redirect_to :action => :index
  end
  
  private

  def set_header
    @header = "Posts - #{action_name}"
  end

  def post_params
    params.require(:post).permit(:body, :title)
  end
end
