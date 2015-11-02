class Question < ActiveRecord::Base
  attr_accessible :content, :title
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 10 }, uniqueness: true
end
