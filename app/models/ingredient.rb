class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  validates :amount, :unit, :name, presence: true
end
