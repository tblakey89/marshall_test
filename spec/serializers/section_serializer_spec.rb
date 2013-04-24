describe SectionSerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:name) }

  it { should have_many(:questions) }
end
