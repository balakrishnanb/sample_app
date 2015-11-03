class Question < ActiveRecord::Base
  attr_accessible :content, :title
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :upvotes, dependent: :destroy
  has_many :upvoters, class_name: 'User', through: :upvotes, source: :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 10 }, uniqueness: true
  default_scope order: 'questions.created_at DESC'
end
