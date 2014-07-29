require 'spec_helper'

describe "membership_types/show", :type => :view do
  before(:each) do
    @membership_type = assign(:membership_type, stub_model(MembershipType,
      :name => "Name",
      :monthlycost => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
  end
end
