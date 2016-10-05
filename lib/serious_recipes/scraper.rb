require 'pry'
class Scraper

  def self.scrape_latest_recipes
    html = open("http://www.seriouseats.com/recipes")
    doc = Nokogiri::HTML(html)
      lr_title_array =[]
      latest_page = doc.css("#posts .module")
      latest_page.each do |r|
        lr_title_array << {
          recipe_name: r.css(".title a").text,
          recipe_url: r.css("a").attribute("href").value,
          recipe_author: r.css("footer .author").text,
        }
      end
      lr_title_array
  end

end
