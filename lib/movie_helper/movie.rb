class MovieHelper::Movie
  attr_accessor :title, :year, :summary, :genre, :mood, :actors, :director, :language, :language, :url, :is_netflix, :is_amazon, :is_elsewhere

  @@all = []

  def initialize(movie_hash)
    movie_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_list(movies)
    movies.each do |movie|
      film = MovieHelper::Movie.new(movie)
    end
  end

  def self.all
    @@all
  end

  def self.latest_netflix
    @@all.select {|movie| movie.is_netflix == true}
  end

  def self.latest_amazon
    @@all.select {|movie| movie.is_amazon == true}
  end

  def self.latest_elsewhere
    @@all.select {|movie| movie.is_elsewhere == true}
  end


end
