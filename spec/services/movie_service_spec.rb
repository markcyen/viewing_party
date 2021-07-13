require 'rails_helper'

RSpec.describe MovieService do
  describe 'class methods' do
    describe '#top_40_movies' do
      it 'returns top movie data' do
        list_top_40_stub

        response = MovieService.top_40_movies

        expect(response).to be_an Array
        expect(response.first).to be_a Hash

        first_top_movie = response.first

        expect(first_top_movie).to have_key :title
        expect(first_top_movie[:title]).to be_a String

        expect(first_top_movie).to have_key :vote_average
        expect(first_top_movie[:vote_average]).to be_a Float
      end
    end

    describe '#get movies' do
      it 'returns search movie data' do
        list_godfather_search_stub

        response = MovieService.get_movies('godfather')

        expect(response).to be_an Array
        expect(response.first).to be_a Hash

        first_top_movie = response.first

        expect(first_top_movie).to have_key :title
        expect(first_top_movie[:title]).to be_a String

        expect(first_top_movie).to have_key :vote_average
        expect(first_top_movie[:vote_average]).to be_a Float
      end
    end
  end
end