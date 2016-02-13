class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  validates :comment, :rating, presence: true

  def responder_name
    user = User.find(self.responder_id)
    user.username
  end

  def count_votes
    total = self.votes.sum(:value)
    self.update_attribute(:vote_count, total)
  end
end
