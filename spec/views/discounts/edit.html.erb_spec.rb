require 'spec_helper'

describe "discounts/edit", :type => :view do
  before(:each) do
    @discount = assign(:discount, stub_model(Discount,
      :name => "MyString",
      :percent => 1.5
    ))
  end

  it "renders the edit discount form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", discount_path(@discount), "post" do
      assert_select "input#discount_name[name=?]", "discount[name]"
      assert_select "input#discount_percent[name=?]", "discount[percent]"
    end
  end
end
