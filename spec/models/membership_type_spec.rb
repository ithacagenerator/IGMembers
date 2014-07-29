require 'spec_helper'

describe MembershipType, :type => :model do

  before { @type = MembershipType.new(name: "ExampleType", monthlycost:5.0)}

  describe "when name is empty" do
    before { @type.name = ' '}

    it { is_expected.not_to be_valid }
  end  
  describe "when cost is empty" do
    before { @type.monthlycost = nil }

    it { is_expected.not_to be_valid }
  end  
end
