require 'spec_helper'

describe Section do
  before { @section = Section.new(order: 1, name: "Testing 1", video_id: "test") }
  subject { @section }

  it { should respond_to(:name) }
  it { should respond_to(:order) }
  it { should respond_to(:video_id) }
  it { should respond_to(:questions) }

  it { should be_valid }

  describe "check when name is blank" do
    before { @section.name = " " }
    it { should_not be_valid }
  end

  describe "when section name is already in use" do
    before do
      section_with_same_name = @section.dup
      section_with_same_name.name = @section.name.upcase
      section_with_same_name.order = 2
      section_with_same_name.video_id = "test1"
      section_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when order number is already in use" do
    before do
      section_with_same_order = @section.dup
      section_with_same_order.order = @section.order
      section_with_same_order.name = "Section 2"
      section_with_same_order.video_id = "test1"
      section_with_same_order.save
    end

    it { should_not be_valid }
  end
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

