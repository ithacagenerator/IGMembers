require 'spec_helper'

describe "StaticPages", :type => :request do


  let(:base_title) { "Ithaca Generator Membership" }

  subject { page }

  shared_examples_for "all static pages" do
    it { is_expected.to have_selector('h1', text: heading) }
    it { is_expected.to have_title(full_title(page_title)) }
  end

  describe "Copyrights page" do
    before {visit copyrights_path}
    let(:heading) {'Copyright Licenses'}
    let(:page_title) {'Copyrights'}

    it_should_behave_like "all static pages"
  end

  describe "Help page" do
    before {  visit help_path }
    let(:heading)    {'Help'}
    let(:page_title) {'Help'}

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    {'About'}
    let(:page_title) {'About'}

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)    {'Contact'}
    let(:page_title) {'Contact'}

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
 #   click_link "About"
 #   expect(page).to have_title(full_title('About'))
 #   click_link "Help"
 #   expect(page).to have_title(full_title('Help'))
 #   click_link "Contact"
 #   expect(page).to have_title(full_title('Contact'))
 #   click_link "Home"
 #   click_link "Sign up now!"
 #   expect(page).to have_title(full_title('Sign up'))
 #   click_link "IG Membership"
 #   expect(page).to have_title(full_title(''))
  end
end
