class MovieHelper::Scraper

  def scrape_movie(link)
    doc = Nokogiri::HTML(open(link))

    movie = MovieHelper::Movie.new

    movie.title = doc.css("h1").children.first.text.strip
    movie.year = doc.css("h1 span.movieyear").first.text
    movie.watch_with = doc.css("span[title='More movies to watch with']").children.text.strip
    movie.watch_when = doc.css("span[title='More movies to watch when']").children.text.strip
    movie.genre = doc.css("span[itemprop='genre']").children.text.strip
    movie.review = doc.css(".review-block span p").text
    movie.stars = doc.css("#agmtw-opened li.meta-item div.infom span").first.children.text
    #e.g. for individual actor/actress: doc.css("#agmtw-opened li.meta-item div.infom span").first.children.first.attributes.first.last.value
    movie.rating = doc.css("span[itemprop='contentRating']").children.text.strip
    movie.language = doc.css("span[title='More from the language']").children.text.strip
    movie.url = link
    movie
  end

  def make_movies(movie_links)
    movie_links.each {|movie_link| scrape_movie(movie_link)}
  end

  def scrape_best_films
    doc = Nokogiri::HTML(open("https://agoodmovietowatch.com/best/"))
    links = doc.css("h3").map {|movie| movie.elements.first.first.last}
    make_movies(links)
  end

  def scrape_latest
    doc = Nokogiri::HTML(open("https://agoodmovietowatch.com/all/new/"))
    links = doc.css(".entry-title").map {|movie| movie.elements.first.first.last}
    best = links.map {|movie_link| self.scrape_movie(movie_link)}
  end


end
