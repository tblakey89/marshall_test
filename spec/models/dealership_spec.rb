require 'spec_helper'

describe Dealership do
  before { @dealership = Dealership.new(name: "test") }
  subject { @dealership }

  it { should respond_to(:name) }
  it { should respond_to(:users)}
  it { should be_valid }
end
