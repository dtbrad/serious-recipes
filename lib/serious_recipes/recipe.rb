require 'pry'
class Recipe

  attr_accessor :recipe_name, :recipe_url, :recipe_author

  @@all =[]

  def self.all
    @@all
  end

  def initialize(recipe_hash)
    recipe_hash.each{|k, v| self.send("#{k}=", v)}
  end

  def self.make_recipes
    Scraper.scrape_latest_recipes.each do |r|
      new_recipe = Recipe.new(r)
      @@all << new_recipe
    end
  end

end
