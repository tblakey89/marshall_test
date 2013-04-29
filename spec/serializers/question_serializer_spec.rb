describe QuestionSerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:question_text) }
  it { should have_attribute(:answer1) }
  it { should have_attribute(:answer2) }
  it { should have_attribute(:answer3) }
  it { should have_attribute(:answer4) }
  it { should have_attribute(:correct) }
end
