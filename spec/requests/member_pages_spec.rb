require 'spec_helper'
require 'pp'

describe 'MemberPages', :type => :request do

  let(:admin) { FactoryGirl.create(:admin) }

  subject {page}

  describe 'as admin' do

    before {sign_in admin}

    describe 'index' do

      let!(:member) { FactoryGirl.create(:member)}

      before do
        visit members_path
      end

      it {is_expected.to have_content('Listing members')}

      describe 'delete links' do
        it { is_expected.to have_link('Destroy')}
        it 'should be able to delete another member' do
          expect { click_link('Destroy', match: :first) }.to change(Member, :count).by(-1)
        end

        it {
          is_expected.not_to have_link('Destroy', href: member_path(admin)) }
      end

    end


    describe 'profile page' do
      let(:member) { FactoryGirl.create(:member) }
      let!(:membertype1) { FactoryGirl.create(:membership_type, name: 'Foo') }
      let!(:membertype2) { FactoryGirl.create(:membership_type, name: 'Bar') }
      let!(:m1) { FactoryGirl.create(:membership,
                                     member: member,
                                     membership_type: membertype1,
                                     start: Date.parse('2011-11-15'),
                                     end: Date.parse('2012-11-14')) }
      let!(:m2) { FactoryGirl.create(:membership,
                                     member: member,
                                     membership_type: membertype2,
                                     start: Date.parse('2013-01-01')) }

      before {visit member_path(member) }

      it {is_expected.to have_content(member.fname)}
      it {is_expected.to have_content(member.lname)}

      describe 'memberships' do
        it { is_expected.to  have_content("#{membertype1.name} Member from #{m1.start.to_s} until #{m1.end.to_s}") }
        it { is_expected.to  have_content("#{membertype2.name} Member since #{m2.start.to_s}") }
        it { is_expected.to  have_link('Edit', href: edit_membership_path(m1)) }
        it { is_expected.to  have_link('Edit', href: edit_membership_path(m2)) }
        it { is_expected.to  have_link('Add Membership', href: new_membership_path(member: member)) }
      end

    end

    describe 'new member page' do
      before { visit new_member_path }

      it {is_expected.to have_content('New member') }
    end

    describe 'new member' do
      before { MembershipType.create(name: 'Test', monthlycost: 5 ) }
      before { Discount.create(name: 'Student', percent: 25 ) }
      before { Discount.create(name: 'Family1', percent: 50 ) }
      before {visit new_member_path }

      let(:submit) { 'Create Member' }

      describe 'with invalid information' do
        it 'should not create a member' do
          expect { click_button submit}.not_to change(Member, :count)
        end
      end

      describe 'with valid information' do
        before do
          fill_in 'Fname', with: 'Example'
          fill_in 'Lname', with: 'User'
          fill_in 'Email', with: 'member@example.com'
          fill_in 'Address', with: '1 Test Way'
          fill_in 'City', with: 'Testville'
          fill_in 'State', with: 'NY'
          fill_in 'Zip', with: '00000'
          fill_in 'Phone', with: '23423422'
          fill_in 'Gnucash', with: 'EXM'
        end

        it 'should create a member' do
          expect { click_button submit }.to change(Member, :count).by(1)
        end

        describe 'after saving the member' do
          before { click_button submit }
          let(:member) { Member.find_by(email: 'member@example.com') }
          it {is_expected.to have_content('Member was successfully created') }

          specify { expect(member.reload.gnucash_id).to eq('EXM') }

        end

      end
    end

    describe 'edit' do

      let(:member) {FactoryGirl.create(:member)}
      before do
        visit edit_member_path(member)
      end

      describe 'page' do
        it { is_expected.to have_content('Editing member')}
      end

      describe 'with invalid information' do
        describe 'with empty city' do
          before do
            fill_in 'City', with: ''
            click_button 'Update Member'
          end
          
          it {is_expected.to have_content("can't be blank")}
        end
      end

      describe 'with valid information' do
        let(:new_name) { 'New Name' }
        let(:new_email) { 'new@example.com' }
        let(:new_address) { '1 New Road' }
        let(:new_city) { 'Newton' }
        let(:new_state) { 'NY' }
        let(:new_zip) { '33333' }
        before do
          fill_in 'Name', with: new_name
          fill_in 'Email', with: new_email
          fill_in 'Address', with: new_address
          fill_in 'City', with: new_city
          fill_in 'State', with: new_state
          fill_in 'Zip', with: new_zip
        end
      end
    end

  end #as admin
end
