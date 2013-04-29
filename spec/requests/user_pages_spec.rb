require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "Signup page" do
    before { visit signup_path }

    it { should have_selector('h3', text: 'Enter Details') }
    it { should have_selector('title', text: full_title('Enter Details')) }
  end

  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.username) }
    it { should have_selector('title', text: user.username) }
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Begin Test" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Enter Details') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username", with: "exampleuser"
        fill_in "Email", with: "example@user.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      let(:exam) { FactoryGirl.create(:exam) }
      before { exam.save }
      let(:section) { exam.sections.build(name: "Section 1", order: 1, video_id: "test") }
      before { section.save }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('example@user.com') }

        it { should have_selector('title', text: exam.name ) }
      end
    end
  end
end
