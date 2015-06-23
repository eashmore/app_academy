require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do
    before(:each) do
      visit("users/new")
      fill_in("Username", with: "eric")
      fill_in("Password", with: "ericeric")
      click_button("Sign Up")
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content("eric")
    end
  end

end

feature "logging in" do
  before(:each) do
    visit("users/new")
    fill_in("Username", with: "eric")
    fill_in("Password", with: "ericeric")
    click_button("Sign Up")

    click_button("Sign Out")
    fill_in("Username", with: "eric")
    fill_in("Password", with: "ericeric")
    click_button("Log In")
  end

  it "shows username on the homepage after login" do
    expect(page).to have_content("eric")
  end
end

feature "logging out" do
  before(:each) do
    visit("users/new")
    fill_in("Username", with: "eric")
    fill_in("Password", with: "ericeric")
    click_button("Sign Up")

    click_button("Sign Out")
  end

  it "begins with logged out state" do
    visit new_user_url
    expect(page).not_to have_content("Sign In")
  end

  it "doesn't show username on the homepage after logout" do
    visit new_session_url
    expect(page).not_to have_content("eric")
  end
end
