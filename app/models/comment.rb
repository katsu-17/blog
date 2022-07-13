class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :article, optional: true

  validates :comment, presence: true
end
