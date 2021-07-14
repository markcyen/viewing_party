class Movie
  attr_reader :id, :title, :vote_average, :summary, :duration, :genres

  def initialize(movie_data)
    @id = movie_data[:id]
    @title = movie_data[:title]
    @vote_average = movie_data[:vote_average]
    @summary = movie_data[:overview]
    @duration = movie_data[:runtime]
    @genres = movie_data[:genres]
  end

  def list_genres
    @genres.map do |genre|
      genre[:name]
    end
  end

  def list_of_10_cast_members(movie_id)
    casting = MovieService.find_cast(movie_id)[:cast] 
    casting.map do |cast|
      "#{cast[:name]} as #{cast[:character]}"
    end[0..9]
  end

  def list_reviews(movie_id)
    reviews = MovieService.find_reviews(movie_id)
    reviews.map do |review|
      "Author: #{review[:author]} \n\n #{review[:content]}"
    end
  end
end