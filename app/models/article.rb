class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true

  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.looks(word)
    @article = Article.where("title LIKE?","%#{word}%")
  end

  def liked?(user)
    likes.where(user_id: user.id).exists?
 end

end
