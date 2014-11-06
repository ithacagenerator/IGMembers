require 'rails_helper'

RSpec.describe "members/index", :type => :view do
  before(:each) do
    assign(:members, [
      Member.create!(
        :lname => "Lname",
        :fname => "Fname",
        :address => "Address",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :email => "Email",
        :phone => "Phone"
      ),
      Member.create!(
        :lname => "Lname",
        :fname => "Fname",
        :address => "Address",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :email => "Email",
        :phone => "Phone"
      )
    ])
  end

  it "renders a list of members" do
    render
    assert_select "tr>td", :text => "Lname".to_s, :count => 2
    assert_select "tr>td", :text => "Fname".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
  end
end
