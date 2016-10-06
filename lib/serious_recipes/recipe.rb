require 'pry'
class Recipe

  attr_accessor :recipe_name, :recipe_url, :recipe_author, :recipe_ingredients, :recipe_description, :recipe_directions

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

  def add_details
    details_hash= Scraper.extract_recipe_details(self.recipe_url)
    details_hash.each {|k, v| self.send("#{k}=", v)}
    self
  end


end
