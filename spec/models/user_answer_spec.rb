require 'spec_helper'

describe UserAnswer do
  let(:user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question) }
  let(:user_answer) { user.user_answers.build(question_id: question.id, answer: 2) }

  subject { user_answer }

  it { should be_valid }

  describe "accessable attributes" do
    it "should not allow access to user_id" do
      expect do
        UserAnswer.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "relation methods" do
    it { should respond_to(:user) }
    it { should respond_to(:question) }
    its(:user) { should == user }
    its(:question) { should == question}
  end

  describe "when user is not present" do
    before { user_answer.user_id = nil }
    it { should_not be_valid }
  end

  describe "when question is not present" do
    before { user_answer.question_id = nil }
    it { should_not be_valid }
  end
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

