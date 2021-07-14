class Movie
  attr_reader :title, :vote_average #, :id

  def initialize(movie_data)
    # @id = movie_data[:id]
    @title = movie_data[:title]
    @vote_average = movie_data[:vote_average]
  end
end