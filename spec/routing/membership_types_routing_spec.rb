require "spec_helper"

describe MembershipTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/membership_types").should route_to("membership_types#index")
    end

    it "routes to #new" do
      get("/membership_types/new").should route_to("membership_types#new")
    end

    it "routes to #show" do
      get("/membership_types/1").should route_to("membership_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/membership_types/1/edit").should route_to("membership_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/membership_types").should route_to("membership_types#create")
    end

    it "routes to #update" do
      put("/membership_types/1").should route_to("membership_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/membership_types/1").should route_to("membership_types#destroy", :id => "1")
    end

  end
end
