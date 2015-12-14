class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  before_action :user_check, only: [:edit, :update, :destroy, :publish, :unpublish]

  def index
    @posts = Post.published.all
  end

  def unpublished
    @posts = Post.unpublished.own_posts(current_user).all
    render :index
  end

  def publish
    @post[:published] = true
    @post.save
    redirect_to posts_path
  end

  def unpublish
    @post[:published] = false
    @post.save
    redirect_to unpublished_posts_path
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def user_check
      unless current_user && current_user.id == @post.user_id || current_user.admin?
        redirect_to post_path, notice: 'У вас нет прав на выполнение этого действия.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :published, category_ids: [])
    end
end
