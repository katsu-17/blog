require 'rails_helper'

RSpec.describe Profile, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  # 名前があれば有効な状態であること
  it "is valid with a name" do
    user = @user
    profile = Profile.new(
      user: user,
      name: "テスト",
    )
    expect(profile).to be_valid
  end

  # 名前がなければ無効な状態であること
  it "is invalid without a name" do
    user = @user
    profile = Profile.new(
      user: user,
      name: nil,
    )
    profile.valid?
    expect(profile.errors[:name]).to include("can't be blank")
  end
end
