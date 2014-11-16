require 'rspec'
require 'spec_helper'

describe 'Changing and Updating passwords', :type => :request do

  let(:admin) { FactoryGirl.create(:admin) }

  subject { page }

  before {sign_in admin}
  describe  'has password change link' do
    it { is_expected.to have_link('Change Password')}
  end

  describe 'on password change page' do
    before { click_link 'Change Password' }

    describe 'can change password normally' do

      let(:digest) {admin.password_digest}
      before do
        fill_in 'New Password', with: 'newPassword'
        fill_in 'Confirm Password', with: 'newPassword'
        click_link 'Change Password'
      end

      it 'should have new password' do
        digest != admin.password_digest
      end
    end


  end

end