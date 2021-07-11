require 'rails_helper'

RSpec.describe "Movie Index" do
  before :each do
    @user = User.create!(email: "andrewpatrick138@gmail.com", password: "cowboy1138")
    @user_2 = User.create!(email: "marky123@gmail.com", password: "spacemonkey123")
    @user_3 = User.create!(email: "BrianZ123@gmail.com", password: "happymonkey123")
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/discover'
  end

  it "displays top rated movies" do
    response_body = File.read("spec/fixtures/top_movies.json")
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=fc8f9a61e60adef6d5af436d96592863").
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