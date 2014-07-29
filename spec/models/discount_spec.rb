require 'spec_helper'

describe Discount, :type => :model do

    before do
    @discount = Discount.new(name: "Example Discount", percent: 25)
  end

  subject { @discount }
  
  it { is_expected.to respond_to(:name)}
  it { is_expected.to respond_to(:percent)}
  it { is_expected.to respond_to(:users)}
end
