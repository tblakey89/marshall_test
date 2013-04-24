FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "tblakey#{n}" }
    sequence(:email) { |n| "tomblakey#{n}@googlemail.com" }
    password "foobar"
    password_confirmation "foobar"
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
