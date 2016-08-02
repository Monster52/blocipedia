require 'rails_helper'

feature 'Visitor signs up' do
  scenario 'with valid username and email and password' do
    sign_up_with 'username', 'valid@example.com', 'password'

    expect(page).to have_content('Blocipedia')
  end
  
  scenario 'with invalid username' do
    sign_up_with '', 'valid@example.com', 'password'
      
    expect(page).to have_content('Sign Up')
  end

  scenario 'with invalid email' do
    sign_up_with 'username', 'invalid_email', 'password'

    expect(page).to have_content('Sign Up')
  end

  scenario 'with blank password' do
    sign_up_with 'username', 'valid@example.com', ''

    expect(page).to have_content('Sign Up')
  end

  def sign_up_with(username, email, password)
    visit new_user_registration_path
    fill_in 'Username', with: username
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign up'
  end
end