require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  # コメントがあれば有効な状態であること
  it "is valid with a comment" do
    user = @user
    comment = user.comments.build(
      comment: "テストコメント"
    )
    expect(comment).to be_valid
  end

  # タイトルがなければ無効な状態であること
  it "is invalid without a comment" do
    user = @user
    comment = user.comments.build(comment: nil)
    comment.valid?
    expect(comment.errors[:comment]).to include("can't be blank")
  end
end
