# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :name
  has_many :questions, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :voted_questions, class_name: 'Question', through: :votes, source: :question
  has_many :answers, dependent: :destroy

  before_save do |user|
    user.email = email.downcase
  end

  validates :name, presence: true, length: { maximum: 50 }
  #validates :email, email: true
end
