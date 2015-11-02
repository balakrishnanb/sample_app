class Question < ActiveRecord::Base
  attr_accessible :content, :title
  belongs_to :user
  has_many :answers, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 10 }, uniqueness: true
  default_scope order: 'questions.created_at DESC'
end
