require 'rails_helper'

RSpec.describe "Dashboard Page" do
  describe 'user dashboard page' do
    before :each do
      @user = User.create!(email: "andrewpatrick138@gmail.com", password: "cowboy1138")
      @user_2 = User.create!(email: "marky123@gmail.com", password: "spacemonkey123")
      @user_3 = User.create!(email: "BrianZ123@gmail.com", password: "happymonkey123")
      @user_4 = User.create!(email: "MegS123@gmail.com", password: "ilovedogs123")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    
    it 'displays sections on user dashboard' do
      visit '/dashboard'

      expect(page).to have_button('Discover Movies')
      expect(page).to have_content('Search friend:')
      expect(page).to have_field('email', type: 'text')
      expect(page).to have_button('Add Friend')
      expect(page).to have_content('Viewing Parties')
    end

    it 'routes to discover page after clicking Discover Movies button' do
      visit '/dashboard'

      click_button('Discover Movies')

      expect(current_path).to eq '/discover'
    end

    it 'displays no friends since none were added' do
      visit '/dashboard'

      expect(page).to have_content('No friends have been added to your list')
    end

    it 'displays friends when added to friends list section with downcase (ActiveRecord)' do
      visit '/dashboard'

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
      visit '/dashboard'

      within("#search_friend") do
        fill_in 'email', with: "andrewpatrick138@gmail.com"
        click_on "Add Friend"
      end

      expect(page).to have_content('No friends have been added to your list')
      expect(page).to have_content("You have entered your own email!")
    end

    it 'displays error message when entering a friend that has already been entered (sad path)' do
      visit '/dashboard'

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
      visit '/dashboard'
      
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
  end
    
  describe "viewing party dashboard" do
    it 'displays user created as a host of a viewing party' do
      @user = User.create!(email: "andrewpatrick138@gmail.com", password: "cowboy1138")
      @user_2 = User.create!(email: "marky123@gmail.com", password: "spacemonkey123")
      @user_3 = User.create!(email: "BrianZ123@gmail.com", password: "happymonkey123")
      @user_4 = User.create!(email: "MegS123@gmail.com", password: "ilovedogs123")
      @user.friends << @user_3
      @user.friends << @user_4

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      
      find_movie_stub
      @shawshank = MovieService.find_movie(278)

      allow(Time).to receive(:now).and_return("2021-07-14 20:18:31.881433 -0400")
      @party_1 = Party.create!(host_id: @user.id, movie_id: @shawshank[:id], title: "The Shawshank Redemption", duration: 160, date: Date.today.strftime('%A, %B %d, %Y'), start_time: Time.now.strftime('%I:%M %P').to_s)
      Invitation.create!(user: @user, party: @party_1, status: 0)
      Invitation.create!(user: @user_3, party: @party_1, status: 1)
      Invitation.create!(user: @user_4, party: @party_1, status: 1)

      @party_2 = Party.create!(host_id: @user.id, movie_id: @shawshank[:id], title: "The Shawshank Redemption", duration: 180, date: Date.today.strftime('%A, %B %d, %Y'), start_time: Time.now.strftime('%I:%M %P').to_s)
      Invitation.create!(user: @user_4, party: @party_2, status: 0)
      Invitation.create!(user: @user, party: @party_2, status: 1)

      visit '/dashboard'
  
      within("#hosted") do
        expect(page).to have_link("The Shawshank Redemption")
        expect(page).to have_content("Hosting")
        expect(page).to_not have_content("Invited")
        expect(page).to have_content("Party Length: 160min")
        expect(page).to have_content("Date: 2021-07-14")
        expect(page).to have_content("Start Time: 08:10pm")
        expect(page).to have_content("Invitee: MegS123@gmail.com")
        expect(page).to have_content("Invitee: BrianZ123@gmail.com")
        expect(page).to_not have_content("Invitee: marky123@gmail.com")
      end
    end

    xit 'displays viewing parties user is invited to' do
      find_movie_stub
      godfather = MovieService.find_movie(278)
      party_1 = Party.create!(host_id: @user_4.id, movie_id: godfather[:id], title: "The Godfather", duration: 160, date: Date.today.strftime('%A, %B %d, %Y'), start_time: Time.now.strftime('%I:%M %p'))
      Invitation.create!(user: @user, party: party_1, status: 1)
      Invitation.create!(user: @user_3, party: party_1, status: 1)
      Invitation.create!(user: @user_4, party: party_1, status: 0)
      refresh

     within("#invited") do
        expect(page).to have_link("The Godfather")
        expect(page).to have_content("Invited")
        expect(page).to_not have_content("Hosting")
        expect(page).to have_content("Date: 7/16/2021")
        expect(page).to have_content("Start Time: 7:00pm")
        expect(page).to have_content("Host: andrewpatrick138@gmail.com")
        expect(page).to have_content("Invitee: MegS123@gmail.com")
        expect(page).to have_content("Invitee: BrianZ123@gmail.com")
        expect(page).to_not have_content("Invitee: marky123@gmail.com")
      end
    end
  end
end