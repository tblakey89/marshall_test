class UserAnswer < ActiveRecord::Base
  attr_accessible :question_id, :answer

  belongs_to :user
  belongs_to :question

  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :answer, presence: true
end
# == Schema Information
#
# Table name: user_answers
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  question_id :integer
#  answer      :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

