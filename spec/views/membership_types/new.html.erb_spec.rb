require 'spec_helper'

describe "membership_types/new" do
  before(:each) do
    assign(:membership_type, stub_model(MembershipType,
      :name => "MyString",
      :monthlycost => "9.99"
    ).as_new_record)
  end

  it "renders new membership_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", membership_types_path, "post" do
      assert_select "input#membership_type_name[name=?]", "membership_type[name]"
      assert_select "input#membership_type_monthlycost[name=?]", "membership_type[monthlycost]"
    end
  end
end
