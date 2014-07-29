require 'spec_helper'
require 'rspec/active_model/mocks'

describe "discounts/show", :type => :view do
  before(:each) do
    @discount = assign(:discount, stub_model(Discount,
      :name => "Name",
      :percent => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1.5/)
  end
end
