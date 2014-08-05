require 'rails_helper'

RSpec.describe Membership, :type => :model do

  let(:user) { FactoryGirl.create(:user)}
  let(:membertype) { FactoryGirl.create(:membership_type)}
  
  before do
    @membership = user.memberships.build(membership_type: @membertype,
                                        start: Date.parse("2012-11-15"))
  end
  
  subject { @membership }

  it { should respond_to(:membership_type)}
  it { should respond_to(:start)}
  it { should respond_to(:end)}
  
  
  it { is_expected.to be_member_on(Date.parse("2012-11-15")) }
  it { is_expected.not_to be_member_on(Date.parse("2012-11-14")) }

  describe "when it ends" do
    before { @membership.end = Date.parse("2013-11-15") }

    it {is_expected.to be_member_on(Date.parse("2013-11-15")) }
    it {is_expected.not_to be_member_on(Date.parse("2013-11-16")) }
  end
end
