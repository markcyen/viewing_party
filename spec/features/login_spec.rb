require 'rails_helper'

RSpec.describe "Login Page" do
  describe "User Login Page" do
    it "can log in with correct user credentials" do
      user = User.create!(email: "andrewpatrick138@gmail.com", password: "cowboy1138")
      visit root_path

      fill_in "email", with: "andrewpatrick138@gmail.com"
      fill_in "password", with: "cowboy1138"
      click_button "Log in"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("Welcome, andrewpatrick138@gmail.com!")
      expect(page).to_not have_content("Link to Registration")
      expect(page).to have_link("Log Out")

      click_link("Log Out")

      expect(current_path).to eq(root_path)
      expect(page).to_not have_link("Log Out")
      expect(page).to have_link("Link to Registration")
    end
  end
end