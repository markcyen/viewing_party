require 'rails_helper'

RSpec.describe 'Movie Show Page' do
  before :each do
    @user = User.create!(email: "andrewpatrick138@gmail.com", password: "cowboy1138")
    @user_2 = User.create!(email: "marky123@gmail.com", password: "spacemonkey123")
    @user_3 = User.create!(email: "BrianZ123@gmail.com", password: "happymonkey123")
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/discover'
  end

  describe 'movie details' do
    it 'display movie attributes' do
      list_top_40_stub
      click_button "Find Top Rated Movies"

      find_movie_stub
      find_cast_stub
      find_reviews_stub

      click_link "The Shawshank Redemption"

      expect(current_path).to eq("/movies/278")
      expect(page).to have_content("The Shawshank Redemption")
      expect(page).to have_content("Vote Average: 8.7")
      expect(page).to have_content("Runtime: 142min")
      expect(page).to have_content("Genre(s): Drama, Crime")
      expect(page).to have_content("Summary:")
      expect(page).to have_content("Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.")
      
      expect(page).to have_content("Cast:")
      within("#cast-278") do
        expect(page).to have_content("Tim Robbins as Andy Dufresne")
        expect(page).to have_content("Morgan Freeman as Ellis Boyd \"Red\" Redding")
        expect(page).to have_content("Bob Gunton as Warden Samuel Norton")
        expect(page).to have_content("William Sadler as Heywood")
        expect(page).to have_content("Clancy Brown as Captain Byron T. Hadley")
        expect(page).to have_content("Gil Bellows as Tommy")
        expect(page).to have_content("Mark Rolston as Bogs Diamond")
        expect(page).to have_content("James Whitmore as Brooks Hatlen")
        expect(page).to have_content("Jeffrey DeMunn as 1946 D.A.")
        expect(page).to have_content("Larry Brandenburg as Skeet")
        expect(page).to_not have_content("Neil Giuntoli as Jigger")
        expect(page).to_not have_content("Brian Libby as Floyd")
      end

      expect(page).to have_content('6 Reviews')

      within("#reviews-278") do
        expect(page).to have_content("Author: elshaarawy")
        expect(page).to have_content("very good movie 9.5/10 محمد الشعراوى")
        expect(page).to have_content("Author: tmdb73913433")
        expect(page).to have_content("Make way for the best film ever made people. **Make way.**")
      end
      
    end
  end
end