class Like < ApplicationRecord

  belongs_to :user
  belongs_to :article

  # def liked_by(article_id)
  #   likes.where(article_id: article_id).exists?
  # end
end
