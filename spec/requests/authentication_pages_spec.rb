require 'spec_helper'

describe "Authentication", :type => :request do

  subject { page }

  describe "signin page" do
    before {visit signin_path}

    it {is_expected.to have_content('Sign in')}
    it {is_expected.to have_title('Sign in')}
  end

  describe "signin" do
    before {visit signin_path}

    describe "with invalid information" do
      before {click_button "Sign in"}

      it {is_expected.to have_title('Sign in') }
      it {is_expected.to have_selector('div.alert.alert-error')}

      describe "after visiting another page" do
        before {click_link "Sign in"}
        it { is_expected.not_to have_selector('div.alert.alert-error')}
      end
    end

    describe "with valid admin information" do
      let(:admin) { FactoryGirl.create(:admin) }
      before { sign_in admin }

      it { is_expected.to have_link('List Members', href: members_path) }
      it { is_expected.to have_link('Add Member',   href: new_member_path) }
      it { is_expected.to have_link('Sign out',     href: signout_path) }
      it { is_expected.not_to have_link('Sign in',  href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it {is_expected.to have_link('Sign in')}
      end
    end
  end

  describe "admin authorization" do
    describe "for non-signed-in users" do
      let(:admin) { FactoryGirl.create(:admin) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_member_path(admin.member)
          fill_in "Email", with: admin.email
          fill_in "Password", with: admin.password
          click_button "Sign in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            expect(page).to have_content('Editing member')
          end
        end
      end

      describe "in the Memberships controller" do

        describe "submitting to the create action" do
          before { post memberships_path }
          specify { expect(response).to redirect_to(root_url) }
        end
      end

    end

    describe "as non-admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      let(:non_admin) { FactoryGirl.create(:user)}

      before { sign_in non_admin, no_capybara: true}

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete member_path(admin.member) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end
