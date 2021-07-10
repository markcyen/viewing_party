require 'rails_helper'

RSpec.describe "Discover Page" do
  describe "Display Discover Page" do
    it "has a find movies button and search feature" do
      user = User.create!(email: "andrewpatrick138@gmail.com", password: "cowboy1138")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/discover'
      expect(page).to have_button('Find Top Rated Movies')
      expect(page).to have_button('Find Movie')
    end
  end
end