class Article < ApplicationRecord
  has_one_attached :image
  has_many :comments, dependent: :destroy
  belongs_to :user

  with_options presence: true do
    validates :title, :text, :image
  end

  with_options numericality: { other_than: 1, message: "を選択して下さい" } do
    validates :genre_id, :country_id
  end

  validates :title, length: { in: (2..40) }
  validates :text, length: { maximum: 1000 }
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :country
end
