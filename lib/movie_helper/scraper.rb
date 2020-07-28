class MovieHelper::Scraper

  def self.scrape_movie(link, category)
    doc = Nokogiri::HTML(open(link))

    hash = {}
    
    hash[:title] = doc.css("span.content-title").children.text.strip
    hash[:year] = doc.css("span.single-year").children.text.strip
    hash[:summary] = doc.css("div.wc-comment-text").children.text.strip
    hash[:genre] = doc.css("span[itemprop='genre']").children.text.strip
    if doc.css("div.infom span").count > 1
      hash[:mood] = doc.css("div.infom span")[1].text.strip
      hash[:actors] = doc.css("div.infom span")[2].text.strip
      hash[:director] = doc.css("div.infom span")[3].text.strip
      hash[:language] = doc.css("div.infom span")[4].text.strip
    end
    hash[:url] = link

    if category == "netflix"
      hash[:is_netflix] =  true
    elsif category == "amazon"
      hash[:is_amazon] = true
    elsif category == "elsewhere"
      hash[:is_elsewhere] = true
    end

    hash
  end

  def self.random
    scrape_movie("https://agoodmovietowatch.com/random/", nil)
  end

  def self.latest_netflix
    doc = Nokogiri::HTML(open("https://agoodmovietowatch.com/all/?on=USA-netflix&by=new"))
    links = doc.css("span.content-title").map {|movie| movie.css("a").first.first.last}
    best = links.map {|movie_link| scrape_movie(movie_link, "netflix")}
  end

  def self.latest_amazon
    doc = Nokogiri::HTML(open("https://agoodmovietowatch.com/all/?on=USA-amazon-prime&by=new"))
    links = doc.css("span.content-title").map {|movie| movie.css("a").first.first.last}
    best = links.map {|movie_link| scrape_movie(movie_link, "amazon")}
  end

  def self.latest_elsewhere
    doc = Nokogiri::HTML(open("https://agoodmovietowatch.com/all/?by=new"))
    links = doc.css("span.content-title").map {|movie| movie.css("a").first.first.last}
    best = links.map {|movie_link| scrape_movie(movie_link, "elsewhere")}
  end


end
