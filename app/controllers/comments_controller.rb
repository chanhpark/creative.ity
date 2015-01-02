class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id]) #finding post
    @comment = Comment.create(params[:comment].permit(:content)) #finding the comment with the params
    @comment.user_id = current_user.id #assigning the user_id to current user
    @comment.post_id = @post.id #assigning the post_id from comments to the id from posts table

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

end
