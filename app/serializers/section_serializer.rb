class SectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :video_id
  has_many :questions
end
