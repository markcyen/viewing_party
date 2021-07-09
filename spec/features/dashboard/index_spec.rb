require 'rails_helper'

RSpec.describe "Dashboard Page" do
  describe 'user dashboard page' do
    it 'displays sections on user dashboard' do
      user = User.create!(email: "andrewpatrick138@gmail.com", password: "cowboy1138")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_link('Discover Movies')
      expect(page).to have_button('Add Friend')
      expect(page).to have_content('Viewing Parties')
    end

    it 'displays no friends since none were added'

    it 'displays friends added to dashboard'

    it 'displays user created as a host of a viewing party'

    it 'displays user as an attendee of a viewing party created by a friend'
  end
end