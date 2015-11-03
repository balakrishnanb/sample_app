class Upvote < ActiveRecord::Base
  belongs_to :question, counter_cache: true
  belongs_to :user
  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :question_id, uniqueness: { scope: :user_id }
end
