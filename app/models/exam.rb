class Exam < ActiveRecord::Base
  attr_accessible :name

  has_many :sections, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
# == Schema Information
#
# Table name: exams
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

