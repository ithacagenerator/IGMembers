require 'spec_helper'

describe "membership_types/index", :type => :view do
  before(:each) do
    assign(:membership_types, [
      stub_model(MembershipType,
        :name => "Name",
        :monthlycost => "9.99"
      ),
      stub_model(MembershipType,
        :name => "Name",
        :monthlycost => "9.99"
      )
    ])
  end

  it "renders a list of membership_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
