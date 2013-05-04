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
  attr_accessible :first_name, :last_name, :email, :dealership_id, :job_title, :time_taken, :score

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  has_many :user_answers, dependent: :destroy
  has_many :questions, through: :user_answers
  belongs_to :dealership

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :job_title, presence: true
  validates :dealership_id, presence: true

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

  def the_time
    if !self.time_taken.nil?
      current_time = self.time_taken/1000
      seconds = current_time % 60
      minutes = (current_time / 60) % 60
      hours = (current_time/3600)
      hours.to_s + ":" + format("%02d",minutes.to_s) + ":" + format("%02d",seconds.to_s)
    end
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
