require 'spec_helper'

describe "MembershipTypes", :type => :request do
  describe "GET /membership_types" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get membership_types_path
      expect(response.status).to be(200)
    end
  end
end
