require 'spec_helper'

xdescribe "Discounts", :type => :request do
  describe "GET /discounts" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get discounts_path
      expect(response.status).to be(200)
    end
  end
end
