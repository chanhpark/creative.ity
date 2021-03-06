class PostsController < ApplicationController
  before_action :find_posts, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:query]
      @posts = Post.search(params[:query])
    else
      @posts = Post.all.order("created_at DESC")
    end
    @posts = @posts.order("created_at DESC")
  end

  def new
    @post = current_user.posts.build
  end

  def show
    @comments = Comment.where(post_id: @post)
    @random_post = Post.where.not(id: @post).order("RANDOM()").first
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Successfully updated your post"
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def upvote
    @post.upvote_by current_user
    redirect_to :back, notice: "You Liked this post"
  end

  def downvote
    @post.downvote_by current_user
    redirect_to :back, notice: "You Disliked this post"
  end

  private

  def find_posts
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :title, :link, :description)
  end
end
