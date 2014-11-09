require 'spec_helper'

describe Member, :type => :model do

  before do
  #   pp(MembershipType.all)
    membertype = MembershipType.create(name: "Basic", monthlycost: 20 )
    membership = Membership.create(member: @member,
    membership_type: membertype, start: Date.today())
    @member = Member.new(lname: "User", fname: "Example", email: "user@example.com",
      address: "123 Example Way", city: "Exampleville",
      state: "EX", zip: "00000", phone: "113-131-4242",
      memberships: [membership])
  end

  subject { @member }

  it { is_expected.to respond_to(:fname) }
  it { is_expected.to respond_to(:lname) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:address) }
  it { is_expected.to respond_to(:city) }
  it { is_expected.to respond_to(:state) }
  it { is_expected.to respond_to(:zip) }

  it { is_expected.to respond_to(:membership_type) }
  it { is_expected.to respond_to(:membership_date) }
  it { is_expected.to respond_to(:membership_end_date) }
  it { is_expected.not_to respond_to(:discounts) }

  it { is_expected.to respond_to(:memberships) }

  it { is_expected.to respond_to(:gnucash_id) }

  it { is_expected.to be_valid }


  describe "when fname is not present" do
    before {  @member.fname = " " }
    it { is_expected.not_to be_valid }
  end

  describe "when lname is not present" do
    before {  @member.lname = " " }
    it { is_expected.not_to be_valid }
  end

  describe "when email is not present" do
    before { @member.email = " "}
    it { is_expected.not_to be_valid }
  end

  describe "when address is not present" do
    before { @member.address = " "}
    it { is_expected.not_to be_valid }
  end
  describe "when city is not present" do
    before { @member.city = " "}
    it { is_expected.not_to be_valid }
  end

  describe "when state is not present" do
    before { @member.state = " "}
    it { is_expected.not_to be_valid }
  end

  describe "when zip is not present" do
    before { @member.zip = " "}
    it { is_expected.not_to be_valid }
  end


  describe "when fname is too long" do
    before {@member.fname = "a" * 51 }
    it {is_expected.not_to be_valid }
  end

  describe "when lname is too long" do
    before {@member.lname = "a" * 51 }
    it {is_expected.not_to be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com member_at_foo.org example.user@foo. foo@bar_baz_com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @member.email = invalid_address
        expect(@member).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.slt@foo.jp a_b@baz.cn]
      addresses.each do |valid_address|
        @member.email = valid_address
        expect(@member).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      member_with_same_email = @member.dup
      member_with_same_email.email = @member.email.upcase
      member_with_same_email.save
    end

    it {is_expected.not_to be_valid}
  end

  describe "knows if member" do

    before do
      membertype =     MembershipType.create(name: "Basic", monthlycost: 20 )
      membership = Membership.create(membership_type: membertype, start: Date.parse("2012-11-15"))
      @member.memberships << membership
    end
    it {is_expected.to be_member_on(Date.parse("2012-11-15")) }
    it {is_expected.to be_member_on(Date.parse("2015-11-15")) }
    it {is_expected.to_not be_member_on(Date.parse("2012-11-14")) }
  end

  describe "knows if expired member" do
    before do
      membertype =     MembershipType.create(name: "Basic", monthlycost: 20 )
      membership = Membership.create(membership_type: membertype,
        start: Date.parse("2012-11-15"),
        end: Date.parse("2015-10-10"))
      @member.memberships = [ membership ]
    end

    it {is_expected.to_not be_member_on(Date.parse("2012-11-14")) }
    it {is_expected.to be_member_on(Date.parse("2012-11-15")) }
    it {is_expected.to be_member_on(Date.parse("2015-10-10")) }
    it {is_expected.to_not be_member_on(Date.parse("2015-10-11")) }

    describe "but has renewed" do
      before do
        membertype = MembershipType.create(name: "Basic", monthlycost: 20 )
        membership = Membership.create(membership_type: membertype,
          start: Date.parse("2016-11-15"))
        @member.memberships << membership
      end

    it {is_expected.to be_member_on(Date.parse("2015-10-10")) }
    it {is_expected.to_not be_member_on(Date.parse("2015-10-11")) }
    it {is_expected.to_not be_member_on(Date.parse("2016-11-14")) }
    it {is_expected.to be_member_on(Date.parse("2016-11-15")) }


    end
  end

  describe "can compute cost" do
    describe '#cost' do
      subject { super().cost }
      it { is_expected.to eq(20) }
    end

#    describe "without a discount" do
#      before do
#        @member.discounts = []
#      end
#
#      subject { super().total_discount }
#      it { is_expected.to eq(0)}
#    end

#    describe "with a discount" do
#      before do
#        # @member.discounts = [Discount.new(percent: 25)]
#      end
#
#      subject { super().total_discount }
#      it { is_expected.to eq(25)}
#    end

#    describe "with multiple discounts" do
#      before do
#        @member.discounts = [Discount.new(percent: 25),
#          Discount.new(percent:50)]
#      end
#
#      subject { super().total_discount }
#      it { is_expected.to eq(62.5)}
#    end

#    xdescribe "has invoice" do
#      let(:invoice) { @member.invoice_for(2013,5).split(',')}
#
#      before do
#        @member.gnucash_id = "EXP"
#        @member.membership_date = Date.parse("2012.11.15")
#      end

#      expect(invoice[0]).to eq("EXP-1305") # Invoice id

#    end
  end
end
