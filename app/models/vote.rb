class Vote < ActiveRecord::Base
  attr_accessible :value
  belongs_to :question
  belongs_to :user
  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :question_id, uniqueness: { scope: :user_id }
end
