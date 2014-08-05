require 'rails_helper'

RSpec.describe "MembershipPages", :type => :request do

  subject { page }

  let(:admin) { FactoryGirl.create(:admin)}
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in admin }

  describe "membership creation" do
    before { visit user_path(user) }
    before { click_button "Add Membership" }

    describe "with invalid information" do

      it "should not create a membership" do
        expect { click_button "Save Membership"}.not_to change(Membership, :count)
      end

      describe "error messages" do
        before { click_button "Save Membership"}
        it {should have_content('error')}
      end
    end
  end  
end
