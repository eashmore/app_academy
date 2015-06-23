class Goal < ActiveRecord::Base
  validates :title, :body, :user_id, presence: true
  belongs_to :user

  after_initialize :ensure_goal_incomplete


  private

  def ensure_goal_incomplete
    self.completed ||= "Incomplete"
  end
end
