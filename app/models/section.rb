class Section < ActiveRecord::Base
  attr_accessible :name, :order, :video_id, :exam_id

  has_many :questions, dependent: :destroy

  belongs_to :exam

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :order, presence: true, uniqueness: true
  validates :video_id, presence: :true, uniqueness: true
end
# == Schema Information
#
# Table name: sections
#
#  id         :integer         not null, primary key
#  order      :integer
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  exam_id    :integer
#  video_id   :string(255)
#

