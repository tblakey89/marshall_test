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

require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com", dealership_id: 1, job_title: "Test Job") }
  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:dealership_id) }
  it { should respond_to(:job_title) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:questions) }
  it { should respond_to(:user_answers) }

  it { should be_valid }

  describe "when first_name is not present" do
    before { @user.first_name = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[ user@foo,com user_at_foo.org example.user@foo. ]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[ user@foo.com A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "answering questions" do
    let(:question) { FactoryGirl.create(:question) }
    before do
      @user.save
      @user.answer_question!(question, question.correct)
    end

    it { should be_answered(question) }
    its(:questions) { should include(question) }
    it { should be_answered_correct(question) }

    describe "when answer is wrong" do
      before do
        @user.unanswer_question!(question)
        @user.answer_question!(question, 5)
      end

      it { should_not be_answered_correct(question) }
    end

    describe "remove answer" do
      before { @user.unanswer_question!(question) }

      it { should_not be_answered(question) }
      its(:questions) { should_not include(question) }
    end
  end
end
