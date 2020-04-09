class Ingridient < ApplicationRecord
  belongs_to :recipe

  validates :label, presence: true
end
