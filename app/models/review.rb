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

  def vote_on_this?(current_user_id)
    !Vote.find_by(voter_id: current_user_id, votable_id: self.id, votable_type: "Response") && current_user_id != self.responder.id
  end
end
