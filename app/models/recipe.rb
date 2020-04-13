class Recipe < ApplicationRecord
  has_many :ingridients, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
end
