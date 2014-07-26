require 'spec_helper'

describe MembershipType do

  before { @type = MembershipType.new(name: "ExampleType", monthlycost:5.0)}

  describe "when name is empty" do
    before { @type.name = ' '}

    it { should_not be_valid }
  end  
  describe "when cost is empty" do
    before { @type.monthlycost = nil }

    it { should_not be_valid }
  end  
end
