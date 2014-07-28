require 'spec_helper'

describe Discount do

    before do
    @discount = Discount.new(name: "Example Discount", percent: 25)
  end

  subject { @discount }
  
  it { should respond_to(:name)}
  it { should respond_to(:percent)}
  it { should respond_to(:users)}
end
