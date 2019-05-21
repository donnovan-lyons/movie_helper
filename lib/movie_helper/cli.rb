class MovieHelper::CLI

# Change the flow so that no scraping happens up front ...
# Instead, scrape only the moveis requested by the user
# Once a set or category is chosen, it should not be scraped again on a subsequent like choice

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
    puts "2. Best Films"
    puts "3. Latest Suggestions"
    puts "4. Exit"
    selector
  end

  def selector
    input = gets.chomp
    case input
    when "1"
      random
    when "2"
      best_films
    when "3"
      latest_suggestions
    when "4" || "exit" || "quit"
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

  def best_films

    if MovieHelper::Movie.best_films.empty?
      puts "Loading..."
      best_films = MovieHelper::Scraper.best_films
      MovieHelper::Movie.create_from_list(best_films)
      puts ""
    end
    puts "Here is a list of our best films:"
    movies = MovieHelper::Movie.best_films
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

  def latest_suggestions
    if MovieHelper::Movie.latest.empty?
      puts "Loading..."
      latest_films = MovieHelper::Scraper.latest
      MovieHelper::Movie.create_from_list(latest_films)
      puts ""
    end
    puts "Here are some of our latest suggestions:"
    movies = MovieHelper::Movie.latest
    movies.each.with_index do |movie, i|
      puts "#{i+1}. #{movie.title}"
    end
    information(movies)
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
    puts "Watch with #{movie.watch_with}"
    puts "Watch when #{movie.watch_when}"
    puts "Genre: #{movie.genre}"
    puts "Selected review: #{movie.review}"
    puts "Movie stars: #{movie.stars}"
    puts "Movie rating: #{movie.rating}"
    puts "Language: #{movie.language}"
  end

  def satisfaction_check
    input = nil
    until input == "yes" ||input == "y"
      puts "Are you satisfied with your movie choice?"
      input = gets.chomp.downcase
      if input == "no" || input == "n"
        try_again
      end
    end
  end

  def try_again
    puts "Would you like to try again?"
    input = gets.chomp.downcase
    if input == "yes" || input == "y"
      list_options
    elsif input == "no" || input == "n"
    else
      try_again
    end
  end

  def goodbye
    puts "Thank you for your using Movie Helper!"
  end
end
