class MovieHelper::Movie
  attr_accessor :title, :year, :watch_with, :watch_when, :genre, :review, :stars, :rating, :language, :url, :is_latest, :is_best

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

  def self.best_films
    @@all.select {|movie| movie.is_best == true}
  end

  def self.latest
    @@all.select {|movie| movie.is_latest == true}
  end


end
