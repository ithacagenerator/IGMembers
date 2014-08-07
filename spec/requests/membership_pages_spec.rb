require 'rails_helper'

RSpec.describe "MembershipPages", :type => :request do

  subject { page }

  let(:admin) { FactoryGirl.create(:admin)}
  let(:user) { FactoryGirl.create(:user) }
  let!(:mtype1) { FactoryGirl.create(:membership_type, name: "Foo") }
  let!(:mtype2) { FactoryGirl.create(:membership_type, name: "Bar") }
  let!(:m1) { FactoryGirl.create(:membership,
                                 user: user,
                                 membership_type: mtype1,
                                 start: Date.parse("2011-11-15"),
                                 end: Date.parse("2012-11-14")) }
  let!(:m2) { FactoryGirl.create(:membership,
                                 user: user,
                                 membership_type: mtype2,
                                 start: Date.parse("2013-01-01")) }
  
  before { sign_in admin }
  
  describe "membership creation" do
    before { visit user_path(user) }
    before { click_link "Add Membership" }
    
    describe "with invalid information" do
      
      it "should not create a membership" do
        expect { click_button "Save Membership"}.not_to change(Membership, :count)
      end
      
      describe "error messages" do
        before { click_button "Save Membership"}
        it {should have_content("can't be blank")}
      end
    end

    describe "with valid information" do

      before do
        select "Foo", from: "Membership type"
        select_date Date.parse("2012-11-15"), from: :membership_start
      end

      it "should create a membership" do
        expect { click_button "Save Membership"}.to change(Membership, :count)
      end

      describe "after saving" do
        before { click_button "Save Membership"}
        it { is_expected.to have_content("Foo Member since 2012-11-15") }
      end
    end         
  end
  
  describe "membership edit" do

    let(:new_type) { "Bar" }
    let(:new_start) { Date.parse("2010-11-15") }
    let(:new_end) { Date.parse("2011-11-15") }
    before { visit edit_membership_path(m1) }

    before do
      select new_type, from: "Membership type"
      select_date new_start, from: :membership_start
      select_date new_end, from: :membership_end
      click_button "Save Changes"
    end

    specify { expect(m1.reload.membership_type.name).to eq mtype2.name }
    specify { expect(m1.reload.membership_type).to eq mtype2 }
    specify { expect(m1.reload.start).to eq new_start }
    specify { expect(m1.reload.end).to eq new_end }

    it { is_expected.to have_content("from #{new_start} until #{new_end}")}
  end
end
