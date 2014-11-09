require 'rails_helper'

RSpec.describe "members/show", :type => :view do
  before(:each) do
    @member = assign(:member, Member.create!(
      :lname => "Lname",
      :fname => "Fname",
      :address => "Address",
      :city => "City",
      :state => "State",
      :zip => "Zip",
      :email => "email@acme.inc",
      :phone => "Phone",
      :gnucash_id => "adsfasdf"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Lname/)
    expect(rendered).to match(/Fname/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Zip/)
    expect(rendered).to match(/email@acme.inc/)
    expect(rendered).to match(/Phone/)
  end
end
