class MovieHelper::CLI

  def call
    greeting
    list_options
    goodbye
  end

  def greeting
    puts "Welcome to Movie Helper. Let's help you find a movie!"
    puts
  end

  def list_options
    puts "Please select an option below:"
    puts "1. Random"
    puts "2. Best Films"
    puts "3. Latest Suggestions"
    selector
  end

  def selector
    input = gets.chomp
    case input
    when "1"
    when "2"
    when "3"
    when "exit" || "quit"
    else
      list_options
    end
  end

  def goodbye
    puts "Thank you for your selection. Enjoy your movie!"
  end
end
