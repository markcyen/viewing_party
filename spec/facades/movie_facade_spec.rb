require 'rails_helper'

RSpec.describe 'MovieFacade' do
  describe '#list_top_40' do
    it 'displays top movie from top rated movies' do
      list_top_40_stub
  
      movie_1 = MovieFacade.list_top_40[0]
      movie_2 = MovieFacade.list_top_40[1]
      movie_21 = MovieFacade.list_top_40[20]

      top_movie_array = MovieFacade.list_top_40.map do |movie|
        movie.title
      end
  
      expect(top_movie_array.size).to eq 40
      expect(movie_1.title).to eq('Dilwale Dulhania Le Jayenge')
      expect(movie_2.title).to eq('The Shawshank Redemption')
      expect(movie_21.title).to eq('The Dark Knight')
    end
  end
  
  describe '#search_for_movies' do
    it 'can search for list of movies' do
      list_godfather_search_stub

      godfather_search = MovieFacade.search_for_movies('godfather')

      godfather_search_array = godfather_search.map do |movie|
        movie.title
      end

      expect(godfather_search).to be_an Array
      expect(godfather_search[0]).to be_a Movie
      expect(godfather_search_array.size).to eq 40
      expect(godfather_search[0].title).to eq('The Godfather')
      expect(godfather_search[20].title).to eq('Ateng The Godfather')
    end
  end
end