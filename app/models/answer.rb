class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  attr_accessible :body
  validates :question_id, presence: true
  validates :body, presence: { message: "cant be blank" }, allow_blank: false
  validates :body, length: { minimum: 10 }, allow_blank: true
  default_scope order: 'answers.created_at ASC'
end
