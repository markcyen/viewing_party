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
      response_body = File.read("spec/fixtures/top_movies_1.json")
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['api_key']}").
        to_return(status: 200, body: response_body, headers: {})
      click_button "Find Top Rated Movies"
  
      expect(current_path).to eq(movies_path)
      expect(page.status_code).to eq(200)
      movie_list = find("#top_movies").all("div") 
      expect(movie_list.size).to eq(20)
  
      within("#top_movies") do
        expect(page).to have_content("The Shawshank Redemption")
        expect(page).to have_content("Gabriel's Inferno Part II")
      end 
    end
  end

  describe 'search movies' do
    it 'can search for movie titles by keyword' do
      response_body_search = File.read("spec/fixtures/search_movies.json")
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['api_key']}").
        to_return(status: 200, body: response_body_search, headers: {})

      response_body_top = File.read("spec/fixtures/top_movies_1.json")
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['api_key']}").
        to_return(status: 200, body: response_body_top, headers: {})

      click_button "Find Top Rated Movies"

      fill_in 'title', with: 'godfather'
      click_button 'Find Movies'

      expect(page).to have_content('The Godfather')
      expect(page).to have_content('The Godfather: Part II')
      expect(page).to_not have_content("Schindler's List")
    end
  end
end
