require 'spec_helper'

describe "membership_types/edit" do
  before(:each) do
    @membership_type = assign(:membership_type, stub_model(MembershipType,
      :name => "MyString",
      :monthlycost => "9.99"
    ))
  end

  it "renders the edit membership_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", membership_type_path(@membership_type), "post" do
      assert_select "input#membership_type_name[name=?]", "membership_type[name]"
      assert_select "input#membership_type_monthlycost[name=?]", "membership_type[monthlycost]"
    end
  end
end
