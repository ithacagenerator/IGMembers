require 'rails_helper'

RSpec.describe Membership, :type => :model do

  let(:user) { FactoryGirl.create(:user, gnucash_id: "FOO")}
  let(:membertype) { FactoryGirl.create(:membership_type, name: "BAR", monthlycost: 23)}
  let!(:membership) { user.memberships.create(membership_type: membertype,
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
      before { @invoice = membership.invoice_for(2013,5).split(",", -1)}
      specify {expect(@invoice[0]).to eq("FOO-1305")} # Invoice ID
      specify {expect(@invoice[1]).to eq(Date.today().to_s())} # Date Opened
      specify {expect(@invoice[2]).to eq("FOO")} # Owner Id
      specify {expect(@invoice[3]).to be_empty} # Billing ID
      specify {expect(@invoice[4]).to be_empty} # Notes
      specify {expect(@invoice[5]).to eq("2013-05-15")} # Invoice Date
      specify {expect(@invoice[6]).to eq("BAR membership for 2013-05-15")} # Description
      specify {expect(@invoice[7]).to be_empty} # Action
      specify {expect(@invoice[8]).to eq("Income:Membership Dues")} # Account
      specify {expect(@invoice[9]).to eq("1")} # Qty
      specify {expect(@invoice[10]).to eq("23.00")} # Price
      specify {expect(@invoice[11]).to eq("%")} # Discount Types
      specify {expect(@invoice[12]).to be_empty} # Discount How
      specify {expect(@invoice[13]).to eq("0")} # discount 
      specify {expect(@invoice[14]).to be_empty} # Taxable
      specify {expect(@invoice[15]).to be_empty} # Tax included
      specify {expect(@invoice[16]).to be_empty} # Tax Table
      specify {expect(@invoice[17]).to eq("2013-05-15")} # Date Posted
      specify {expect(@invoice[18]).to eq("2013-05-22")} # Due Date
      specify {expect(@invoice[19]).to eq("Assets:Accounts Receivable")} # account posted
      specify {expect(@invoice[20]).to be_empty} # memo posted
      specify {expect(@invoice[21]).to be_empty} # accumulate splits
    end

    describe "generates csv with one discount" do
      before {membership.discounts.create(name: "TestingDiscount", percent: 10)}
      before { @invoice = membership.invoice_for(2013,5).split(",", -1)}

      # GnuCash 2.6.3 has Bug 734183 - Importing invoices with discounts yields invoice line items with incorrect subtotals and bizzare editing behavior
      # which affects this import. The current workaround is to pre-compute the discount, rather than letting GnuCash do it.
      
      specify {expect(@invoice[10]).to eq("20.70")}
      specify {expect(@invoice[13]).to eq("0")}
      specify {expect(@invoice[4]).to eq("10.0% TestingDiscount discount applied")}
    end
    describe "generates csv with two discount" do
      before do
        membership.discounts.create(name: "Fred", percent: 10)
        membership.discounts.create(name: "Wilma", percent: 15)
        @invoice = membership.invoice_for(2013,5).split(",", -1)
      end

      # GnuCash 2.6.3 has Bug 734183 - Importing invoices with discounts yields invoice line items with incorrect subtotals and bizzare editing behavior
      # which affects this import. The current workaround is to pre-compute the discount, rather than letting GnuCash do it.
      
      specify {expect(@invoice[10]).to eq("17.60")} # 23 * .90 * .85 = 17.595
      specify {expect(@invoice[13]).to eq("0")}
      specify {expect(@invoice[4]).to eq("10.0% Fred and 15.0% Wilma discounts applied")}
    end
  end
end
