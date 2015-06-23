module AuthHelper
  def sign_up_as(username)
    fill_in("Username", with: username)
    fill_in("Password", with: "ericeric")
    click_button("Sign Up")
  end

  def sign_in_as(username)
    visit("session/new")
    fill_in("Username", with: username)
    fill_in("Password", with: "ericeric")
    click_button("Log In")
  end

  def create_goal(title, body)
    fill_in("Title", with: title)
    fill_in("Body", with: body)
  end
end
