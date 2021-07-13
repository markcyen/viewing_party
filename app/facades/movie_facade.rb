class MovieFacade
  def self.list_top_40
    MovieService.top_40_movies.map do |movie|
      Movie.new(movie)
    end
  end

  def self.search_for_movies(query)
    search_movies = MovieService.get_movies(query)
    search_movies.map do |movie|
      Movie.new(movie)
    end
  end
end