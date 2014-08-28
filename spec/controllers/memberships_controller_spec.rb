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

  describe "GET users/invoices?month=x&year=y" do
    it "assigns the requested membership_type as @membership_type" do
      get 'users/invoices', {:month => 3, :year => 2014}, valid_session
      expect(response.status).to eq(200)
    end
  end

end
