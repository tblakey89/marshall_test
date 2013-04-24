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

require 'spec_helper'

describe Question do
  let(:section) { FactoryGirl.create(:section) }
  before { @question = section.questions.build(question_text: "How are you today?", answer1: "Good", answer2: "Great", answer3: "OK", answer4: "Bad", correct: 2) }
  subject { @question }

  it { should respond_to(:question_text) }
  it { should respond_to(:section) }
  it { should respond_to(:user_answers) }
  it { should respond_to(:users) }
  it { should respond_to(:section_id) }
  it { should be_valid }

  describe "when question_text is blank" do
    before { @question.question_text = " " }

    it { should_not be_valid }
  end

  describe "when question is already in use" do
    before do
      question_with_same_text = @question.dup
      question_with_same_text.question_text = @question.question_text.upcase
      question_with_same_text.save
    end

    it { should_not be_valid }
  end

  describe "when user answers question" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      @question.save
      user.answer_question!(@question, @question.correct)
    end

    its(:users) { should include(user) }

    describe "when user removes answer" do
      before { user.unanswer_question!(@question) }

      its(:users) { should_not include(user) }
    end
  end

  describe "section"  do
    describe "when section is nil" do
      before { @question.section_id = nil }

      it { should_not be_valid }
    end

    its(:section) { should == section }
  end
end
