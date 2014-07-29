require 'spec_helper'
require 'rspec/active_model/mocks'

describe "discounts/index", :type => :view do
  before(:each) do
    assign(:discounts, [
      stub_model(Discount,
        :name => "Name",
        :percent => 1.5
      ),
      stub_model(Discount,
        :name => "Name",
        :percent => 1.5
      )
    ])
  end

  it "renders a list of discounts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
