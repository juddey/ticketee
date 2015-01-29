require "rails_helper"

RSpec.feature "Admins can edit states" do
  let!(:state) { FactoryGirl.create :state, name: "New"}

  before do
    login_as(FactoryGirl.create(:user, :admin))
    visit "/"
  end

  scenario "marking a state as default" do
    click_link "Admin"
    click_link "States"
    within list_item("New") do
      click_link "Make Default"
    end

    expect(page).to have_content("'New' is now the default state.")
  end

end