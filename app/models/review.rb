class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  validates :comment, :rating, presence: true
end
