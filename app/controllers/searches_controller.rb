class SearchesController < ApplicationController

  def search
    @articles = Article.page(params[:page]).per(12).looks(params[:word])
  end
end
