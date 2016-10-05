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

  def self.extract_recipe_details(recipe_url)
    recipe_detail ={}
    html = open(recipe_url)
    recipe_page = Nokogiri::HTML(html)
    recipe_detail[:recipe_ingredients] = recipe_page.css(".ingredient").collect {|i| i.text}
    recipe_detail[:recipe_description] = recipe_page.css("#entry-text .recipe-introduction-body p").text.split("]")[1]
    overfilled_array = recipe_page.css(".recipe-procedure-text p").collect {|step| step.text}
    proper_array = overfilled_array.select {|string| !string.empty?}
    recipe_detail[:recipe_directions] = proper_array
    recipe_detail
end


end
