class MovieHelper::Movie
  attr_accessor :title, :year, :watch_with, :watch_when, :genre, :review, :stars, :rating, :language, :url

  @@best_films = []
  @@latest = []

  def initialize(movie_hash)
    movie_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.create_best_films(movies)
    movies.each do |movie|
      film = MovieHelper::Movie.new(movie)
      @@best_films << film
    end
  end

  def self.create_latest(movies)
    movies.each do |movie|
      film = MovieHelper::Movie.new(movie)
      @@latest << film
    end
  end

  def self.best_films
    @@best_films
  end

  def self.latest
    @@latest
  end

  def display
    puts "Title: #{self.title} (#{self.year})"
    puts "Watch with #{self.watch_with}"
    puts "Watch when #{self.watch_when}"
    puts "Genre: #{self.genre}"
    puts "Selected review: #{self.review}"
    puts "Movie stars: #{self.stars}"
    puts "Movie rating: #{self.rating}"
    puts "Language: #{self.language}"
  end

end
