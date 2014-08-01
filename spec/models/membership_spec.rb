require 'rails_helper'

RSpec.describe Membership, :type => :model do

  let(:membertype) { MembershipType.new(name: ExampleType, monthlycost: 25)}
  let(:user) { User.new() }
  
  before { @membership = Membership.new(membership_type: @membertype,
      user: @user, start: Date.parse("2012-11-15")) }

  subject { @membership }

  it { is_expected.to be_member_on(Date.parse("2012-11-15")) }
  it { is_expected.not_to be_member_on(Date.parse("2012-11-14")) }

  describe "when it ends" do
    before { @membership.end = Date.parse("2013-11-15") }

    it {is_expected.to be_member_on(Date.parse("2013-11-15")) }
    it {is_expected.not_to be_member_on(Date.parse("2013-11-16")) }
  end
end
