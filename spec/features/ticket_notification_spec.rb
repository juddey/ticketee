require 'rails_helper'

RSpec.feature "Ticket Notifications" do
  let!(:alice) { FactoryGirl.create(:user, email: "alice@example.com") }
  let!(:bob) { FactoryGirl.create(:user, email: "bob@example.com") }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) do
      FactoryGirl.create(:ticket,
              project: project,
              author: alice)
  end

  before do
    assign_role!(alice, :manager, project)
    assign_role!(bob, :manager, project)

    login_as(bob)
    visit "/"
  end

  scenario "Ticket owner recieves notifications about comments" do
    click_link project.name
    click_link ticket.title
    fill_in "Text", with: "Is it out yet?"
    click_button "Create Comment"

    email = find_email!(alice.email)
    subject = "[ticketee] #{project.name} - #{ticket.title}"
    expect(email.subject).to include(subject)
    click_first_link_in_email(email)

    within("#ticket h2") do
      expect(page).to have_content(ticket.title)
    end
  end
end

