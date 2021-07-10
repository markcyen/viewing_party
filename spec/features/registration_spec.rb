require 'rails_helper'

RSpec.describe "Registration Page" do
  describe 'user registration page' do
    it 'creates new user' do
      visit root_path

      click_link 'Link to Registration'

      email = 'andrew@smith.com'
      password = 'andrewsmith'
      confirm_password = 'andrewsmith'

      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: confirm_password
 
      click_on 'Register'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Welcome, #{email}!")
    end

    it 'password sad path' do
      visit '/register'

      email = 'andrew@smith.com'
      password = 'andrewsmith'
      confirm_password = 'andrewsmiths'

      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: confirm_password

      click_on 'Register'

      expect(page).to have_content("Password confirmation doesn't match Password! Please try again!")
    end

    it 'email sad path' do
      visit '/register'

      email = 'andrew#smith.com'
      password = 'andrewsmith'
      confirm_password = 'andrewsmith'

      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: confirm_password

      click_on 'Register'

      expect(page).to have_content('Email is invalid! Please try again!')
    end
  end
end
