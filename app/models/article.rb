class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true

  has_one_attached :image

  def self.looks(word)
    @article = Article.where("title LIKE?","%#{word}%")
  end

end
