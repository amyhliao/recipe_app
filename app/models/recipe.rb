class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  has_many :reviews
  belongs_to :user

  validates :title, :directions, :prep_time, :cook_time, :total_time, presence: true
end
