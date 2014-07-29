require 'spec_helper'

describe "discounts/new", :type => :view do
  before(:each) do
    assign(:discount, stub_model(Discount,
      :name => "MyString",
      :percent => 1.5
    ).as_new_record)
  end

  it "renders new discount form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", discounts_path, "post" do
      assert_select "input#discount_name[name=?]", "discount[name]"
      assert_select "input#discount_percent[name=?]", "discount[percent]"
    end
  end
end
