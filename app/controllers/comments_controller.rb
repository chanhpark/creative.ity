class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id]) #finding post
    @comment = Comment.find_or_initialize_by(post: @post, user: current_user)
    # @comment.user_id = current_user.id #assigning the user_id to current user
    # @comment.post_id = @post.id #assigning the post_id from comments
    # to the id from posts table

    if @comment.new_record?
      @comment.attributes = comment_params
      if @comment.save
        redirect_to post_path(@post),
        notice: "Successfully added your comment"
      else
        render "new"
      end
    else
      redirect_to post_path(@post),
      notice: "You have already commented on this post"
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @user = current_user
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @comment.post, notice: "Comment Updated Successfully"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to post_path(@post), notice: "Comment Deleted Successfully"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
    # @comment = Comment.create(params[:comment].permit(:content))
    # finding the comment with the params
  end
end
