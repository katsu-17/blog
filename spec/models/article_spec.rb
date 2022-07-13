require 'rails_helper'

RSpec.describe Article, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  # タイトル、内容があれば有効な状態であること
  it "is valid with a title and boby" do
    user = @user
    article = user.articles.build(
      title: "テストタイトル",
      body: "テスト本文",
    )
    expect(article).to be_valid
  end

  # タイトルがなければ無効な状態であること
  it "is invalid without a title" do
    user = @user
    article = user.articles.build(
      title: nil,
      body: "テスト本文",
    )
    article.valid?
    expect(article.errors[:title]).to include("can't be blank")
  end

  # 内容がなければ無効な状態であること
  it "is invalid without a body" do
    user = @user
    article = user.articles.build(
      title: "テストタイトル",
      body: nil,
    )
    article.valid?
    expect(article.errors[:body]).to include("can't be blank")
  end

  # 文字列に一致するメッセージを検索する
  describe "search article for a term" do
    before do
      @article1 = @user.articles.create(
        title: "This is the first article",
        body: "テスト本文",
      )
      @article2 = @user.articles.create(
        title: "This is the second article",
        body: "テスト本文",
      )
      @article3 = @user.articles.create(
        title: "First, get a motorcycle",
        body: "テスト本文",
      )
    end

    # 一致するデータが見つかるとき
    context "when a match is found" do
      it "returns articles that match the search term" do
        expect(Article.looks("first")).to include(@article1, @article3)
      end
    end

    # 一致するデータが1件も見つからないとき
    context "when no match is found" do
      # 空のコレクションを返すこと
      it "returns an empty collection" do
        expect(Article.looks("post")).to be_empty
      end
    end
  end

  describe "check if the article is liked by the person" do
    before do
      @article = @user.articles.create(
        title: "This is the first article",
        body: "テスト本文",
      )
      @user2 = FactoryBot.create(:user)
    end

    context "when liked" do
      it "returns true" do
        Like.create(
          user_id: @user2.id,
          article_id: @article.id,
        )
        expect(@article.liked?(@user2)).to be true
      end
    end

    context "when not liked" do
      it "returns false" do
        expect(@article.liked?(@user2)).to be false
      end
    end
  end
end
