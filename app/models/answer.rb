class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  attr_accessible :body
  validates :question_id, presence: true
  default_scope order: 'answers.created_at ASC'
end
