require 'spec_helper'

describe Exam do
  before { @exam = Exam.new(name: "Test 1") }
  subject { @exam }

  it { should respond_to(:name) }
  it { should respond_to(:sections) }
  it { should be_valid }

  describe "when name is blank" do
    before { @exam.name = " " }

    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      examdup = @exam.dup
      examdup.save
    end

    it { should_not be_valid }
  end
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

