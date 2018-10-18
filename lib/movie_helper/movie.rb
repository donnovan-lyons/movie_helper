class MovieHelper::Movie
  attr_accessor :title, :year, :watch_with, :watch_when, :genre, :review, :stars, :rating, :language

  def self.scrape_random
    doc = Nokogiri::HTML(open("https://agoodmovietowatch.com/random/"))


    random = self.new

    random.title = doc.css("h1").children.first.text.strip
    random.year = doc.css("h1 span.movieyear").first.text
    random.watch_with = doc.css("#agmtw-opened li.meta-item-with div.infom span").text
    random.watch_when = doc.css("#agmtw-opened li.meta-item-with div.infom span").text
    random.genre = doc.css("#agmtw-opened li.meta-item-genre div.infom span").text.strip
    random.review = doc.css(".review-block span p").text
    random.stars = doc.css("#agmtw-opened li.meta-item div.infom span").first.children.text
    #e.g. for individual actor/actress: doc.css("#agmtw-opened li.meta-item div.infom span").first.children.first.attributes.first.last.value
    random.rating = doc.css("#agmtw-opened li.meta-item-rating div.infom span").first.children.text
    random.language = doc.css("#agmtw-opened div.meta-item-last div.infom").last.children.last.text
    binding.pry
  end
  #
  # def self.best_films
  #   doc = Nokogiri::HTML(open("https://agoodmovietowatch.com/best/"))
  #
  #   best = self.new
  #
  #   best.title =
  #   best.review =
  #   best.stars =
  #   best.rating =
  #   best.language =
  # end
  #
  # def self.latest
  #   doc = Nokogiri::HTML(open("https://agoodmovietowatch.com/all/new/"))
  #
  #   latest = self.new
  #
  #   latest.title =
  #   latest.review =
  #   latest.stars =
  #   latest.rating =
  #   latest.language =
  # end
end
