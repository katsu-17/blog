require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with an email and a password" do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = FactoryBot.build(:user, email: "")
    expect(user).to_not be_valid
  end


  it "is invalid without a password" do
    user = FactoryBot.build(:user, password: "")
    expect(user).to_not be_valid
  end

  it "is invalid with a password which is already taken" do
    user1 = FactoryBot.create(:user, email: "suzuki@example.com")
    user2 = FactoryBot.build(:user, email: user1.email)
    expect(user2).to_not be_valid
  end
end
