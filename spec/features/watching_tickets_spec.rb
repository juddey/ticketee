require 'rails_helper'

RSpec.feature "Watching tickets" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) do
    FactoryGirl.create(:ticket,
      project: project,
      author: user)
  end

  before do
    assign_role!(user, "viewer", project)
    login_as(user)
    visit "/"
  end

  scenario "Ticket watch toggling" do
    click_link project.name
    click_link ticket.title
    within("#watchers") do
      expect(page).to have_content(user.email)
    end

    click_button "Stop watching this ticket"
    expect(page).to have_content("You are no longer watching " +
                                 "this ticket.")
    within ("#watchers") do
      expect(page).to_not have_content(user.email)
    end

    click_button "Watch this ticket"
    expect(page).to have_content("You are now watching this ticket.")
    within ("#watchers") do
      expect(page).to have_content(user.email)
    end
  end
end