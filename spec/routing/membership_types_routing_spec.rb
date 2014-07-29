require "spec_helper"

describe MembershipTypesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/membership_types")).to route_to("membership_types#index")
    end

    it "routes to #new" do
      expect(get("/membership_types/new")).to route_to("membership_types#new")
    end

    it "routes to #show" do
      expect(get("/membership_types/1")).to route_to("membership_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/membership_types/1/edit")).to route_to("membership_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/membership_types")).to route_to("membership_types#create")
    end

    it "routes to #update" do
      expect(put("/membership_types/1")).to route_to("membership_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/membership_types/1")).to route_to("membership_types#destroy", :id => "1")
    end

  end
end
