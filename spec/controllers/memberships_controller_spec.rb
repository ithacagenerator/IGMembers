require 'rails_helper'

describe MembershipsController, :type => :controller do
  # This should return the minimal set of attributes required to create a valid
  # MembershipType. As you add validations to MembershipType, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString", monthlycost: 5 } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MembershipTypesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET invoices?month=x&year=y" do
    it "displays the invoices for the requested month and year" do
      visit '/invoices?month=3&year=2014'
      expect(page).to have_content 'blah'
    end
  end

end
