require 'rails_helper'

RSpec.describe "InvoicePaths", :type => :feature do
  describe "GET /invoice_paths" do

    let(:admin) { FactoryGirl.create(:admin) }
    subject {page}
    before{ sign_in admin }

    it "have content blah" do
      visit invoices_path
      expect(page).to have_content("blah")
    end
  end
end
