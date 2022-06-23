class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.page(params[:page]).per(12).order(created_at: :desc)
  end

  def show
    @profile = Profile.find_by(user_id: @article.user_id)
    @article = Article.find(params[:id])
    @comments = @article.comments
    @comment = current_user.comments.new
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to @article, notice: "作成できました"
    else
      render :new, alert: "作成できませんでした"
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "更新できました"
    else
      render :edit, alert: "更新できませんでした"
    end
  end

  def destroy
    if @article.destroy
      redirect_to root_path, notice: "削除しました"
    else
      redirect_to root_path, alert: "削除できませんでした"
   end
  end

  private
    def find_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body, :image)
    end

    def validate_user
      if @article.user != current_user
        redirect_to root_path, alert: "自分の投稿ではありません"
      end
    end

end
