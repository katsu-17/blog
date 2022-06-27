class LikesController < ApplicationController
  before_action :article_params

  def create
    @article_like = Like.new(user_id: current_user.id, article_id: params[:article_id])
    @article_like.save
  end

  def destroy
    @article_like = Like.find_by(user_id: current_user.id, article_id: params[:article_id])
    @article_like.destroy
  end

  private

  def article_params
    @article = Article.find(params[:article_id])
  end
end
