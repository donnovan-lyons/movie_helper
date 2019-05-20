class MovieHelper::Movie
  attr_accessor :title, :year, :watch_with, :watch_when, :genre, :review, :stars, :rating, :language, :url, :is_latest, :is_best

  #@@best_films = []
  #@@latest = []

  @@all = []

  def initialize(movie_hash)
    movie_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  # def self.create_best_films(movies)
  #   movies.each do |movie|
  #     film = MovieHelper::Movie.new(movie)
  #     @@best_films << film
  #   end
  # end
  # ^^ vvv make these into one method
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

  # def display
  #   puts "Title: #{self.title} (#{self.year})"
  #   puts "Watch with #{self.watch_with}"
  #   puts "Watch when #{self.watch_when}"
  #   puts "Genre: #{self.genre}"
  #   puts "Selected review: #{self.review}"
  #   puts "Movie stars: #{self.stars}"
  #   puts "Movie rating: #{self.rating}"
  #   puts "Language: #{self.language}"
  # end

end
