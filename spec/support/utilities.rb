include ApplicationHelper

def valid_signin(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
end

RSpec::Matchers.define :have_error_messages do |message|
  match do |page|
    page.should have_selector('div.alert-error', text: message)
  end
end

def sign_in(user)
  visit root_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
  cookies[ :remember_token] = user.remember_token
end
