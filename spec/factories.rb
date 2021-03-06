FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "thomas#{n}" }
    sequence(:last_name) { |n| "blakey#{n}" }
    sequence(:email) { |n| "tomblakey#{n}@googlemail.com" }
    dealership_id 1
    job_title "Test Job"
  end

  factory :question do
    question_text "How are you today?"
    answer1 "I am good thanks"
    answer2 "I am great thanks"
    answer3 "I am ok thanks"
    answer4 "I am not too good"
    correct 2
    section
  end

  factory :section do
    name "Section 1"
    order 1
    video_id "test"
    exam
  end

  factory :exam do
    name "Test 1"
  end
end
