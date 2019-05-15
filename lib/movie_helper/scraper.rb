class MovieHelper::Scraper

  def self.scrape_movie(link)
    doc = Nokogiri::HTML(open(link))
    
    hash = {}

    hash[:title] = doc.css("h1").children.first.text.strip
    if doc.css("h1 span.movieyear").first != nil
      hash[:year] = doc.css("h1 span.movieyear").first.text
    end
    hash[:watch_with] = doc.css("span[title='More movies to watch with']").children.text.strip
    hash[:watch_when] = doc.css("span[title='More movies to watch when']").children.text.strip
    hash[:genre] = doc.css("span[itemprop='genre']").children.text.strip
    hash[:review] = doc.css(".review-block span p").text
    hash[:stars] = doc.css("#agmtw-opened li.meta-item div.infom span").first.children.text
    #e.g. for individual actor/actress: doc.css("#agmtw-opened li.meta-item div.infom span").first.children.first.attributes.first.last.value
    hash[:rating] = doc.css("span[itemprop='contentRating']").children.text.strip
    hash[:language] = doc.css("span[title='More from the language']").children.text.strip
    hash[:url] = link
    hash
  end

  def self.random
    scrape_movie("https://agoodmovietowatch.com/random/")
  end

  def self.best_films
    doc = Nokogiri::HTML(open("https://agoodmovietowatch.com/best/"))
    links = doc.css("h3").map {|movie| movie.elements.first.first.last}
    best = links.map {|movie_link| scrape_movie(movie_link)}
  end

  def self.latest
    doc = Nokogiri::HTML(open("https://agoodmovietowatch.com/all/new/"))
    links = doc.css(".entry-title").map {|movie| movie.elements.first.first.last}
    latest = links.map {|movie_link| scrape_movie(movie_link)}
  end


end
