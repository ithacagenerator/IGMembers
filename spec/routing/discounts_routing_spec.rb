require "spec_helper"

describe DiscountsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/discounts")).to route_to("discounts#index")
    end

    it "routes to #new" do
      expect(get("/discounts/new")).to route_to("discounts#new")
    end

    it "routes to #show" do
      expect(get("/discounts/1")).to route_to("discounts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/discounts/1/edit")).to route_to("discounts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/discounts")).to route_to("discounts#create")
    end

    it "routes to #update" do
      expect(put("/discounts/1")).to route_to("discounts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/discounts/1")).to route_to("discounts#destroy", :id => "1")
    end

  end
end
