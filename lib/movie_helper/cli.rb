class MovieHelper::CLI

  def call
    greeting
    list_options
    satisfaction_check
    goodbye
  end

  def greeting
    puts "Welcome to Movie Helper!"
    puts
  end

  def list_options
    puts "Let us help you find a movie!"
    puts ""
    puts "Please select an option below:"
    puts "1. Random"
    puts "2. Latest on Netflix"
    puts "3. Latest on Amazon"
    puts "4. Latest Elsewhere"
    puts "5. Exit"
    selector
  end

  def selector
    input = gets.chomp
    case input
    when "1"
      random
    when "2"
      latest_netflix
    when "3"
      latest_amazon
    when "4"
      latest_elsewhere
    when "5" || "exit" || "quit"
    else
      puts "Invalid request."
      puts ""
      list_options
    end
  end

  def random
    puts "One moment while we randomly select your movie..."
    movie_hash = MovieHelper::Scraper.random
    movie = MovieHelper::Movie.new(movie_hash)
    puts ""
    puts "Your random movie is:"
    puts ""
    puts movie.title
    puts ""
    more_info(movie)
  end

  def latest_netflix
    if MovieHelper::Movie.latest_netflix.empty?
      puts "Loading..."
      latest_netflix_films = MovieHelper::Scraper.latest_netflix
      MovieHelper::Movie.create_from_list(latest_netflix_films)
      puts ""
    end
    puts "Here are our latest Netflix films:"
    movies = MovieHelper::Movie.latest_netflix
    movies.each.with_index do |movie, i|
      puts "#{i+1}. #{movie.title}"
    end
    information(movies)
  end

  def latest_amazon
    if MovieHelper::Movie.latest_amazon.empty?
      puts "Loading..."
      latest_amazon_films = MovieHelper::Scraper.latest_amazon
      MovieHelper::Movie.create_from_list(latest_amazon_films)
      puts ""
    end
    puts "Here are our latest Amazon films:"
    movies = MovieHelper::Movie.latest_amazon
    movies.each.with_index do |movie, i|
      puts "#{i+1}. #{movie.title}"
    end
    information(movies)
  end

  def latest_elsewhere
    if MovieHelper::Movie.latest_elsewhere.empty?
      puts "Loading..."
      latest_elsewhere_films = MovieHelper::Scraper.latest_elsewhere
      MovieHelper::Movie.create_from_list(latest_elsewhere_films)
      puts ""
    end
    puts "Here are our latest films:"
    movies = MovieHelper::Movie.latest_elsewhere
    movies.each.with_index do |movie, i|
      puts "#{i+1}. #{movie.title}"
    end
    information(movies)
  end

  def information(movies)
    puts ""
    puts "For more information on one of these movies, please type 1 - #{movies.count}."
    puts "To return to the main menu, please type 'list'"

    input = gets.chomp
    if input.to_i.between?(1, movies.count)
      input = input.to_i - 1
      more_info(movies[input])
    elsif input == "list"
      list_options
    else
      information(movies)
    end
  end

  

  def more_info(movie)
    puts "Would you like more information about this movie?"
    puts "Type Y to get more information, or list to go back to the main menu."
    input = gets.chomp
    if input.upcase == "Y"
      display(movie)
    elsif input.downcase == "list"
      list_options
    else
      more_info(movie)
    end
  end

  def display(movie)
    puts "Title: #{movie.title} (#{movie.year})"
    puts "Summary: #{movie.summary}"
    puts "Genre: #{movie.genre}"
    puts "Mood: #{movie.mood}"
    puts "Movie actors: #{movie.actors}"
    puts "Movie director: #{movie.director}"
    puts "Language: #{movie.language}"
  end

  def satisfaction_check
    input = nil
    until input == "yes" ||input == "y"
      puts "Are you satisfied with your movie choice?"
      input = gets.chomp.downcase
      if input == "no" || input == "n"
        input = try_again
      end
    end
  end

  def try_again
    puts "Would you like to try again?"
    input = gets.chomp.downcase
    if input == "yes" || input == "y"
      list_options
    elsif input == "no" || input == "n"
      "yes"
    else
      try_again
    end
  end

  def goodbye
    puts "Thank you for your using Movie Helper!"
  end
end
