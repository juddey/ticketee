require "rails_helper"

feature "Editing Projects" do
  let (:user) { FactoryGirl.create(:user) }
  let (:project) { FactoryGirl.create(:project, name: "Sublime Text 3") }

  before do
    assign_role!(user, :manager, project)
    login_as(user)
    visit "/"
    click_link "Sublime Text 3"
    click_link "Edit Project"
  end

  scenario "Updaing a Project" do
    fill_in "Name", with: "Sublime Text 3 beta"
    click_button "Update Project"

    expect(page).to have_content("Project has been updated.")
  end

  scenario "Updating a project" do
    fill_in "Name", with: "Sublime Text 3 beta"
    click_button "Update Project"

    expect(page).to have_content("Project has been updated.")
  end

  scenario "Updating a project with invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Project"
    
    expect(page).to have_content("Project has not been updated.")
  end

end