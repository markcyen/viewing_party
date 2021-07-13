class MovieService
  def self.top_40_movies
    response_1 = Faraday.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['api_key']}&language=en-US&page=1")

    response_2 = Faraday.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['api_key']}&language=en-US&page=2")

    parse_json(response_1)[:results] + parse_json(response_2)[:results]
  end

  def self.get_movies(query)
    response_1 = Faraday.get('https://api.themoviedb.org/3/search/movie') do |req|
      req.params['api_key'] = ENV['api_key']
      req.params['language'] = 'en-US'
      req.params['query'] = query
      req.params['page'] = '1'
    end

    response_2 = Faraday.get('https://api.themoviedb.org/3/search/movie') do |req|
      req.params['api_key'] = ENV['api_key']
      req.params['language'] = 'en-US'
      req.params['query'] = query
      req.params['page'] = '2'
    end

    parse_json(response_1)[:results] + parse_json(response_2)[:results]
  end

  def self.find_movie(movie_id)
    response = Faraday.get("https://api.themoviedb.org/3/movie/#{movie_id}") do |req|
      req.params['api_key'] = ENV['api_key']
      req.params['language'] = 'en-US'
    end

    parse_json(response)
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end