require 'spec_helper'
require 'rails_helper'

feature "the goal creation process" do

  it "has a new goal page" do
    visit("users/new")
    sign_up_as("eric")
    visit "users/1/goals/new"
    expect(page).to have_content "New Goal"
  end

  feature "creates a goal" do
    before(:each) do
      visit("users/new")
      sign_up_as("eric")
      click_button("New Goal")
      fill_in("Title", with: "Be the best")
      fill_in("Body", with: "Do it")
      choose("Private")
      click_button("Create Goal")
    end

    it "shows a goal on the author's page" do
      expect(page).to have_content("Be the best")
    end
  end
end

feature "can edit a goal" do

  before(:each) do
    visit("users/new")
    sign_up_as("eric")
    click_button("New Goal")
    create_goal("Be the best","Do it")
    choose("Private")
    click_button("Create Goal")

    click_button("Edit Goal")
  end

  it "has an edit page" do
    expect(page).to have_content("Edit Goal")
    expect(page).to have_content("Do it")
  end

  it "updates the goal" do
    fill_in("Title", with: "Be the worst")
    fill_in("Body", with: "Don't do it")
    click_button("Update Goal")

    expect(page).to have_content("Be the worst")
    expect(page).to have_content("Don't do it")
    expect(page).to have_content("eric")
  end
end

feature "goals can be private or public" do
  feature "should be private" do
    before(:each) do
      visit("users/new")
      sign_up_as("eric")
      click_button("New Goal")
      create_goal("Be the best", "Do it")
      choose("Private")
      click_button("Create Goal")
    end

    it "can't be seen by other users" do
      click_button("Sign Out")
      visit(new_user_url)
      sign_up_as("mikey")


      expect(page).to have_content("mikey")
      expect(page).not_to have_content("Be the best")
      expect(page).not_to have_content("Do it")
    end

    it "can be seen by author" do


      expect(page).to have_content("Be the best")
      expect(page).to have_content("Do it")
      expect(page).to have_content("eric")
    end
  end

  feature "should be public" do
    before(:each) do
      visit("users/new")
      sign_up_as("eric")
      click_button("New Goal")
      create_goal("Be the best", "Do it")
      choose("Public")
      click_button("Create Goal")
    end

    it "can be seen by other users" do
      click_button("Sign Out")
      visit(new_user_url)
      sign_up_as("mikey")

      expect(page).to have_content("mikey")
      expect(page).to have_content("Be the best")
      expect(page).to have_content("Do it")
    end
  end

  feature "can be complete" do
    before(:each) do
      visit("users/new")
      sign_up_as("eric")
      click_button("New Goal")
      create_goal("Be the best", "Do it")
      choose("Public")
      click_button("Create Goal")
    end

    it "is uncompleted initially" do
      expect(page).to have_content("Incomplete")
    end

    it "is completed" do
      click_button("Completed?")
      expect(page).to have_content("Complete")
    end
  end
end
