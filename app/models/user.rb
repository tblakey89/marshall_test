# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  username        :string(255)
#  email           :string(255)
#  dateofbirth     :datetime
#  aboutme         :text
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :aboutme, :dateofbirth, :email, :username, :password, :password_confirmation

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  has_many :user_answers, dependent: :destroy
  has_many :questions, through: :user_answers

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_secure_password

  def answered?(the_question)
    user_answers.find_by_question_id(the_question.id)
  end

  def answer_question!(the_question, the_answer)
    user_answers.create!(question_id: the_question.id, answer: the_answer)
  end

  def unanswer_question!(the_question)
    user_answers.find_by_question_id(the_question.id).destroy
  end

  def answered_correct?(the_question)
    user_answers.find_by_question_id(the_question.id).answer == questions.find(the_question.id).correct
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
