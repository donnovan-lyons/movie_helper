class MovieHelper::CLI

  def call
    greeting
    binding.pry
    load
    list_options
    goodbye
  end

  def greeting
    puts "Welcome to Movie Helper!"
    puts
    puts "Loading..."
  end

  def load
    best_films = MovieHelper::Scraper.best_films
    MovieHelper::Movie.create_best_films(best_films)
    puts "...47%..."
    latest_films = MovieHelper::Scraper.latest
    MovieHelper::Movie.create_latest(latest_films)
    puts "...Complete."
    puts ""
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
      list_options
    end
  end

  def random
    puts "One moment while we randomly select your movie..."
    movie_hash = MovieHelper::Scraper.random
    movie = MovieHelper::Movie.new(movie_hash)
    puts ""
    puts "Your random movie is:"
    puts movie.title
    more_info(movie)
    satisfaction_check
  end

  def best_films
    puts "Here is a list of our best films:"
    movies = MovieHelper::Movie.best_films
    movies.each.with_index do |movie, i|
      puts "#{i+1}. #{movie.title}"
    end
    puts "For more information one one of these movies, please type 1 - #{movies.count}."
    puts "To return to the main menu, please type 'list'"

    input = gets.chomp
    if input.to_i.between?(1, movies.count)
      input = input.to_i - 1
      more_info(movies[input])
    else
      list_options
    end
    satisfaction_check
  end

  def latest_suggestions
    puts "Here are some of our latest suggestions:"
    movies = MovieHelper::Movie.latest
    movies.each.with_index do |movie, i|
      puts "#{i+1}. #{movie.title}"
    end
    puts "For more information one one of these movies, please type 1 - #{movies.count}."
    puts "To return to the main menu, please type 'list'"

    input = gets.chomp
    if input.to_i.between?(1, movies.count)
      input = input.to_i - 1
      more_info(movies[input])
    else
      list_options
    end
    satisfaction_check
  end

  def more_info(movie)
    puts "Would you like more information about this movie?"
    puts "Type Y to get more information, or list to go back to the main menu."
    # binding.pry
    input = gets.chomp
    if input.upcase == "Y"
      movie.display
    elsif input.downcase == "list"
      list_options
    else
      more_info(movie)
    end
  end

  def satisfaction_check
    puts "Are you satisfied with your movie choice?"

    input = gets.chomp.downcase

    if input == "yes" || input == "y"
      return
    else
      puts "Would you like to try again?"
      new_input = gets.chomp.downcase
      if new_input == "yes" || new_input == "y"
        list_options
      end
    end
  end

  def goodbye
    puts "Thank you for your using Movie Helper!"
  end
end
