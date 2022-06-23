class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: root_path)
      flash[:notice] = 'コメントできました'
    else
      redirect_back(fallback_location: root_path)
      flash.now[:alert] = 'コメントできませんでした'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :article_id)
  end

end
