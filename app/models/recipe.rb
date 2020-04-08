class Recipe < ApplicationRecord
  validates :title, presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
end
