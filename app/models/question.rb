# == Schema Information
#
# Table name: questions
#
#  id            :integer         not null, primary key
#  question_text :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  answer1       :text
#  answer2       :text
#  answer3       :text
#  answer4       :text
#  correct       :integer
#  section_id    :integer
#

class Question < ActiveRecord::Base
  attr_accessible :question_text, :answer1, :answer2, :answer3, :answer4, :correct, :section_id, :order

  has_many :user_answers, dependent: :destroy
  has_many :users, through: :user_answers

  belongs_to :section

  validates :question_text, presence: true, uniqueness: { case_sensitive: false }
  validates :answer1, presence: true
  validates :answer2, presence: true
  validates :answer3, presence: true
  validates :answer4, presence: true
  validates :correct, presence: true
  validates :section_id, presence: true

  validates_numericality_of :correct, only_integer: true, allow_nil: true,
    :greater_than_or_equal_to => 1,
    :less_than_or_equal_to => 4,
    :message => "can only be whole number between 1 and 4."

  def correct_answer
    case self.correct
    when 1
      return self.answer1
    when 2
      return self.answer2
    when 3
      return self.answer3
    when 4
      return self.answer4
    end
  end
end
