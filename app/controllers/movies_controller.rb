class MoviesController < ApplicationController
  def index
    @user = current_user

    if !params[:title].present?
      response_top_movies = Faraday.get('https://api.themoviedb.org/3/movie/top_rated') do |req|
        req.params['api_key'] = ENV["api_key"]
      end
      json_top_movies = JSON.parse(response_top_movies.body, symbolize_names: true)
      @top_movies_array = json_top_movies[:results]
    else
      response_search_movies = Faraday.get('https://api.themoviedb.org/3/search/movie') do |req|
        req.params['api_key'] = ENV['api_key']
      end
      json_search_movie = JSON.parse(response_search_movies.body, symbolize_names: true)
      @search_movie = json_search_movie[:results]
    end
  end
end
