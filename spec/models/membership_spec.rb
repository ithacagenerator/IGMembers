require 'rails_helper'

RSpec.describe Membership, :type => :model do

  let(:user) { FactoryGirl.create(:user, gnucash_id: "FOO")}
  let(:membertype) { FactoryGirl.create(:membership_type, name: "BAR", monthlycost: 23)}
  let!(:membership) { user.memberships.build(membership_type: membertype,
                                        start: Date.parse("2012-11-15"))}
  
  subject { membership }

  it { is_expected.to respond_to(:membership_type)}
  it { is_expected.to respond_to(:start)}
  it { is_expected.to respond_to(:end)}
  it { is_expected.to respond_to(:discounts) }
  
  it { is_expected.to be_member_on(Date.parse("2012-11-15")) }
  it { is_expected.not_to be_member_on(Date.parse("2012-11-14")) }

  describe "when it ends" do
    before { membership.end = Date.parse("2013-11-15") }

    it {is_expected.to be_member_on(Date.parse("2013-11-15")) }
    it {is_expected.not_to be_member_on(Date.parse("2013-11-16")) }
  end

  describe "invoicing" do

    before { membership.end = Date.parse("2013-11-10")}
    
    it { is_expected.not_to be_invoiceable_on(2012,10)}
    it { is_expected.to be_invoiceable_on(2012,11)}
    it { is_expected.to be_invoiceable_on(2013,5)}
    it { is_expected.to be_invoiceable_on(2013,10)}
    it { is_expected.not_to be_invoiceable_on(2013,11)}

    describe "generates csv" do
      before { @invoice = membership.invoice_for(2013,5).split(",")}
      expect(@invoice[0]).to be("FOO-1305") # Invoice ID
      expect(@invoice[1]).to be(Date.today().to_s()) # Date Opened
      expect(@invoice[2]).to be("FOO") # Owner Id
      expect(@invoice[3]).to be_empty # Billing ID
      expect(@invoice[4]).to be_empty # Notes
      expect(@invoice[5]).to be("2013-05-15") # Invoice Date
      expect(@invoice[6]).to be("BAR membership for 2013-05-15") # Description
      expect(@invoice[7]).to be_empty # Action
      expect(@invoice[8]).to be("Income:Membership Dues") # Account
      expect(@invoice[9]).to be("1") # Qty
      expect(@invoice[10]).to be("23") # Price
      expect(@invoice[11]).to be("%") # Discount Types
      expect(@invoice[12]).to be_empty # Discount How
      expect(@invoice[13]).to be("0") # discount 
      expect(@invoice[14]).to be_empty # Taxable
      expect(@invoice[15]).to be_empty # Tax included
      expect(@invoice[16]).to be_empty # Tax Table
      expect(@invoice[17]).to be("2013-05-15") # Date Posted
      expect(@invoice[18]).to be("2013-05-22") # Due Date
      expect(@invoice[19]).to be("Assets:Accounts Receivable") # account posted
      expect(@invoice[20]).to be_empty # memo posted
      expect(@invoice[21]).to be_empty # accumulate splits
    end
  end
end
