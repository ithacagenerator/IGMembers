require 'spec_helper'
require 'pp'

describe "UserPages", :type => :request do

  subject {page}

  describe "index" do

    let(:user) { FactoryGirl.create(:user)}
    
    before do
      sign_in user
      visit users_path
    end

    it {is_expected.to have_title('All users')}
    it {is_expected.to have_content('All users')}

    describe "pagination" do

      before(:all) { 30.times {FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it {is_expected.to have_selector('div.pagination')}
      
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it { is_expected.not_to have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { is_expected.to have_link('delete', href: user_path(User.first))}
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it {is_expected.not_to have_link('delete', href: user_path(admin))}
      end
    end    
  end
  

  describe "profile page" do
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
                                 

    before {sign_in user}
    before {visit user_path(user) }

    it {is_expected.to have_content(user.name)}
    it {is_expected.to have_title(user.name)}

    describe "memberships" do
      it { is_expected.to  have_content("#{mtype1.name} Member from #{m1.start.to_s} until #{m1.end.to_s}") }
      it { is_expected.to  have_content("#{mtype2.name} Member since #{m2.start.to_s}") }
    end
    
  end

  describe "signup page" do
    before {visit signup_path}

    it {is_expected.to have_content('Sign up') }
    it {is_expected.to have_title(full_title('Sign up')) }
  end

  describe "signup" do
    before { MembershipType.create(name: "Test", monthlycost: 5 ) }
    before { Discount.create(name: "Student", percent: 25 ) }
    before { Discount.create(name: "Family1", percent: 50 ) }
    before {visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit}.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar", match: :prefer_exact
        fill_in "Street", with: "1 Test Way"
        fill_in "City", with: "Testville"
        fill_in "State", with: "NY"
        fill_in "Zip", with: "00000"
        select "Test", from: "Membership type"
        select_date Date.parse("2011-11-15"), from: "user_membership_date"        

        fill_in "Confirm Password", with: "foobar", match: :prefer_exact
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before {click_button submit}
        let(:user) { User.find_by(email: 'user@example.com') }

        it {is_expected.to have_link('Sign out') }
        it {is_expected.to have_title(user.name) }
        it { is_expected.to have_selector('div.alert.alert-success', text: 'Welcome') }

        specify { expect(user.reload.discounts).to be_empty }
        specify { expect(user.reload.gnucash_id).to eq("EXM") }

      end
      
      describe "and one discounts" do
        before do
          check "Student"
          click_button submit
        end
        
        let(:user) { User.find_by(email: 'user@example.com') }
        specify { expect(user.discounts.size).to eq(1) }
      end
    end
  end

  describe "edit" do
    before { Discount.create(name: "Student", percent: 25 ) }
    before { Discount.create(name: "Family1", percent: 50 ) }
    
    let(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { is_expected.to have_content("Update your profile")}
      it { is_expected.to have_title("Edit user") }
      it { is_expected.to have_link('change', href: 'http://gravatar.com/emails')}
      it { is_expected.not_to have_field("user[password]") }
    end

    describe "with invalid information" do
      before {click_button "Save changes" }

      it { is_expected.to have_content('error')}
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      let(:new_street) { "1 New Road" }
      let(:new_city) { "Newton" }
      let(:new_state) { "NY" }
      let(:new_zip) { "33333" }
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Street", with: new_street
        fill_in "City", with: new_city
        fill_in "State", with: new_state
        fill_in "Zip", with: new_zip        
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
      end

      describe "and no discounts" do
        before do
          click_button "Save changes"
        end
        
        it { is_expected.to have_title(new_name) }
        it { is_expected.to have_selector('div.alert.alert-success') }
        it { is_expected.to have_link('Sign out', href: signout_path)}
        specify { expect(user.reload.name).to eq new_name }
        specify { expect(user.reload.email).to eq new_email }
        
        specify { expect(user.reload.discounts).to be_empty }
      end

      describe "and one discounts" do
        before do
          check "Student"
          click_button "Save changes"
        end
        
        it { is_expected.to have_title(new_name) }
        it { is_expected.to have_selector('div.alert.alert-success') }
        it { is_expected.to have_link('Sign out', href: signout_path)}
        specify { expect(user.reload.name).to eq new_name }
        specify { expect(user.reload.email).to eq new_email }
        
        specify { expect(user.reload.discounts).to_not be_empty }
      end
      
    end
  end
end

  
