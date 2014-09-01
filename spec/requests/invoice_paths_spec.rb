require 'rails_helper'

RSpec.describe "InvoicePaths", :type => :feature do
  describe "GET /invoice_paths" do
    it "have content blah" do
      visit '/invoices'
      print current_path
      expect(page).to have_content("blah")
    end
  end
end
