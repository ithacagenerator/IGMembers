require 'rails_helper'

RSpec.describe "MembershipPages", :type => :request do

  subject { page }

  let(:admin) { FactoryGirl.create(:admin)}
  let(:user) { FactoryGirl.create(:user) }
   
  before { sign_in admin }

  describe "membership creation" do
    before { Discount.create(name: "Student", percent: 25 ) }
    before { Discount.create(name: "Family1", percent: 50 ) }  
    before { MembershipType.create(name: "Foo", monthlycost: 75 ) }    
    before { visit user_path(user) }
    before { click_link "Add Membership" }

    describe "page content" do
      it {is_expected.to have_content('Start') }
      it {is_expected.to have_content('End') }
      it {is_expected.to have_content('Membership type') } 
      it {is_expected.to have_content('Discounts') } 
      it {is_expected.to have_content('Student') }
      it {is_expected.to have_content('Family1') }                           
    end

    describe "with invalid information" do

      it "should not create a membership" do
        expect { click_button "Save Membership"}.not_to change(Membership, :count)
      end

      describe "error messages" do
        before { click_button "Save Membership"}
        it { is_expected.to have_content("can't be blank")}
      end

    end
    
    describe "with valid information" do

     before do
       select "Foo", from: "Membership type"
       select_date Date.parse("2012-11-15"), from: :membership_start
     end

     it "should create a membership" do
       expect { click_button "Save Membership"}.to change(Membership, :count)
       expect { it.to have_content("New membership create for Foo") }              
     end
     
   end    
   
    describe "valid with one discount" do

     before do
       select "Foo", from: "Membership type"       
       select_date Date.parse("2012-11-15"), from: :membership_start
       check "Student"
     end

     it "should create a membership" do
       expect { click_button "Save Membership"}.to change(Membership, :count)
       expect { it.to have_content("New membership create for Foo") }       
       expect { Membership.last.discounts.count.to equal(1) } 
     end
     
   end       

    describe "valid with two discount" do

     before do
       select "Foo", from: "Membership type"       
       select_date Date.parse("2012-11-15"), from: :membership_start
       check "Student"
       check "Family1"
     end

     it "should create a membership" do
       expect { click_button "Save Membership"}.to change(Membership, :count)
       expect { it.to have_content("New membership create for Foo") }              
       expect { Membership.last.discounts.count.to equal(1) } 
     end
    
   end       

    
  end  

end
