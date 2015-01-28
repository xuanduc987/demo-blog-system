class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :can_comment, only: [:create]
  before_action :correct_user, only: [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Your comment had been posted! Yay!"
      redirect_to entry_path(@comment.entry)
    else
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment had been deleted."
    redirect_to request.referrer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :entry_id)
  end

  def can_comment
    redirect_to root_url unless can_comment_on?(Entry
      .find_by(id: params[:comment][:entry_id]))
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
