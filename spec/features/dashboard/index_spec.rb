require 'rails_helper'

RSpec.describe "Dashboard Page" do
  describe 'user dashboard page' do
    before :each do
      @user = User.create!(email: "andrewpatrick138@gmail.com", password: "cowboy1138")
      @user_2 = User.create!(email: "marky123@gmail.com", password: "spacemonkey123")
      @user_3 = User.create!(email: "BrianZ123@gmail.com", password: "happymonkey123")
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/dashboard'
    end
    
    it 'displays sections on user dashboard' do
      expect(page).to have_button('Discover Movies')
      expect(page).to have_content('Search friend:')
      expect(page).to have_field('email', type: 'text')
      expect(page).to have_button('Add Friend')
      expect(page).to have_content('Viewing Parties')
    end

    it 'routes to discover page after clicking Discover Movies button' do
      click_button('Discover Movies')

      expect(current_path).to eq '/discover'
    end

    it 'displays no friends since none were added' do
      expect(page).to have_content('No friends have been added to your list')
    end

    it 'displays friends when added to friends list section with downcase (ActiveRecord)' do
      within("#search_friend") do
        fill_in 'email', with: @user_2.email
        click_on "Add Friend"
      end

      within("#search_friend") do
        fill_in 'email', with: @user_3.email
        click_on "Add Friend"
      end
      
      expect(current_path).to eq('/dashboard')
      expect(page).to_not have_content('No friends have been added to your list')
      expect(page).to have_content(@user_2.email)
      # Utilize ActiveRecord of downcased email to be shown on dashboard
      expect(page).to have_content("BrianZ123@gmail.com")
    end

    it 'displays error message when entering user email (sad path)' do
      within("#search_friend") do
        fill_in 'email', with: "andrewpatrick138@gmail.com"
        click_on "Add Friend"
      end

      expect(page).to have_content('No friends have been added to your list')
      expect(page).to have_content("You have entered your own email!")
    end

    it 'displays error message when entering a friend that has already been entered (sad path)' do
      within("#search_friend") do
        fill_in 'email', with: @user_2.email
        click_on "Add Friend"
      end

      within("#search_friend") do
        fill_in 'email', with: @user_2.email
        click_on "Add Friend"
      end

      expect(page).to have_content("You entered a friend who already exists on your list!")
    end

    it 'displays error message when leaving search field blank or entering incorrect email address (sad path)' do
      within("#search_friend") do
        fill_in 'email', with: " "
        click_on "Add Friend"
      end

      expect(page).to have_content("Invalid Email!")

      visit '/dashboard'

      expect(page).to_not have_content("Invalid Email!")

      within("#search_friend") do
        fill_in 'email', with: "andrewsmith#yahoo.com"
        click_on "Add Friend"
      end

      expect(page).to have_content("Invalid Email!")
    end

    it 'displays user created as a host of a viewing party'

    it 'displays user as an attendee of a viewing party created by a friend'
  end
end