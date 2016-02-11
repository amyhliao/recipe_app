class Recipe < ActiveRecord::Base
  has_many :ingredients
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  has_many :reviews
  belongs_to :user

  validates :title, :directions, :prep_time, :cook_time, :total_time, presence: true

  def count_votes
    total = self.votes.sum(:value)
    self.update_attribute(:vote_count, total)
  end

  # def sorted_reviews
  #   if best_review_id
  #     best_rev = Review.find(best_review_id)
  #     rev_arr = self.reviews.select{|rev| rev.id != best_review_id}
  #     sort_array_by_points(rev_arr).unshift(best_rev)
  #   else
  #     rev_arr = self.reviews.dup
  #     sort_array_by_points(rev_arr)
  #   end
  # end

  def self.sort_by_votes
    Review.all.order('vote_count DESC')
  end

  def self.sort_by_trendiness
    Review.all.where('created_at >= ?', DateTime.now - 7).order('view_count DESC')
  end

  def self.sort_by_recentness
    Review.all.order('created_at DESC')
  end

  def vote_on_this?(current_user_id)
    !Vote.find_by(voter_id: current_user_id, votable_id: self.id, votable_type: "Review") && current_user_id != self.asker.id
  end

  private

  def sort_array_by_points(rev_arr)
    rev_arr.sort_by{ |rev| rev.vote_count }.reverse
  end
end
