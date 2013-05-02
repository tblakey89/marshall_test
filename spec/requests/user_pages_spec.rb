require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "Signup page" do
    before { visit signup_path }

    it { should have_selector('h3', text: 'Enter Details') }
    it { should have_selector('title', text: full_title('Enter Details')) }
  end

  describe "signup" do
    before do
      visit root_path
      fill_in "password", with: "password"
      click_button submit
    end
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
        Dealership.new(name: "Test Town").save
        fill_in "first_name", with: "example"
        fill_in "last_name", with: "user"
        fill_in "Email", with: "example@user.com"
        fill_in "job_title", with: "Test job"
        select "Test Town", from: "Dealership"
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
