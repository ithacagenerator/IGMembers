require 'rails_helper'

RSpec.describe "members/new", :type => :view do
  before(:each) do
    assign(:member, Member.new(
      :lname => "MyString",
      :fname => "MyString",
      :address => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :email => "MyString",
      :phone => "MyString"
    ))
  end

  it "renders new member form" do
    render

    assert_select "form[action=?][method=?]", members_path, "post" do

      assert_select "input#member_lname[name=?]", "member[lname]"

      assert_select "input#member_fname[name=?]", "member[fname]"

      assert_select "input#member_address[name=?]", "member[address]"

      assert_select "input#member_city[name=?]", "member[city]"

      assert_select "input#member_state[name=?]", "member[state]"

      assert_select "input#member_zip[name=?]", "member[zip]"

      assert_select "input#member_email[name=?]", "member[email]"

      assert_select "input#member_phone[name=?]", "member[phone]"
    end
  end
end
