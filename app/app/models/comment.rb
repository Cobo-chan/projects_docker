class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :comment, presence: true
  validates :comment, length: { maximum: 100 }
end
