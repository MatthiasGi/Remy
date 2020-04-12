class Step < ApplicationRecord
  belongs_to :recipe

  validates :number, presence: true
  validates :description, presence: true
end
