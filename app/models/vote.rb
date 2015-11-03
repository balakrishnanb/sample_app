class Vote < ActiveRecord::Base
  UP = 1
  DOWN = 2
  def up?
    return self.value == UP
  end
  attr_accessible :value
  def save_question_score
    if self.value == UP
      self.question.increment!(:score)
    else
      self.question.decrement!(:score)
    end
  end
  def revert_question_score
    if self.value == UP
      self.question.decrement!(:score)
    else
      self.question.increment!(:score)
    end
  end
  after_save :save_question_score
  after_destroy :revert_question_score
  belongs_to :question
  belongs_to :user
  validates :value,  presence: true
  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :question_id, uniqueness: { scope: :user_id }
end
