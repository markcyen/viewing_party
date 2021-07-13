require 'rails_helper'

RSpec.describe "Movie Index" do
  before :each do
    @user = User.create!(email: "andrewpatrick138@gmail.com", password: "cowboy1138")
    @user_2 = User.create!(email: "marky123@gmail.com", password: "spacemonkey123")
    @user_3 = User.create!(email: "BrianZ123@gmail.com", password: "happymonkey123")
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/discover'

  end

  describe 'top movies' do
    it "displays top rated movies" do
      list_top_40_stub
      click_button "Find Top Rated Movies"
  
      expect(current_path).to eq(movies_path)
      expect(page.status_code).to eq(200)
      movie_list = find("#top_movies").all("div") 
      expect(movie_list.size).to eq(40)
  
      within("#top_movies") do
        expect(page).to have_content("The Shawshank Redemption")
        expect(page).to have_content("Gabriel's Inferno Part II")
      end 
    end
  end

  describe 'search movies' do
    it 'can search for movie titles by keyword' do
      list_top_40_stub

      click_button "Find Top Rated Movies"

      list_godfather_search_stub

      fill_in 'search', with: 'godfather'
      click_button 'Find Movies'

      expect(page).to have_content('Francis and The Godfather')
      expect(page).to have_content('The Russian Godfather')
      expect(page).to_not have_content("Schindler's List")
    end
  end
end
