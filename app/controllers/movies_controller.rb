class MoviesController < ApplicationController
  def index
    @user = current_user
    response = Faraday.get('https://api.themoviedb.org/3/movie/top_rated') do |req|
      req.params['api_key'] = ENV["api_key"]
    end
    json = JSON.parse(response.body, symbolize_names: true)
    @movies_array = json[:results]
  end
end