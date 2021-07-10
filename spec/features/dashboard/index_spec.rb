require 'rails_helper'

RSpec.describe "Dashboard Page" do
  describe 'user dashboard page' do
    before :each do
       user = User.create!(email: "andrewpatrick138@gmail.com", password: "cowboy1138")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    
    it 'displays sections on user dashboard' do

      visit '/dashboard'

      expect(page).to have_button('Discover Movies')
      expect(page).to have_button('Add Friend')
      expect(page).to have_content('Viewing Parties')
    end
    it 'routes to discover page after clicking Discover Movies button' do
      visit '/dashboard'
      
      click_button('Discover Movies')

      expect(current_path).to eq '/discover'
    end
    it 'displays no friends since none were added'

    it 'displays friends added to dashboard'

    it 'displays user created as a host of a viewing party'

    it 'displays user as an attendee of a viewing party created by a friend'
  end
end