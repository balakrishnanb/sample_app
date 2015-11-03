class Question < ActiveRecord::Base
  attr_accessible :content, :title, :score
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :voters, class_name: 'User', through: :votes, source: :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 10 }, uniqueness: true
  default_scope order: 'questions.score DESC'
end
