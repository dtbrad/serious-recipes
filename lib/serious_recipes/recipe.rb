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

  def ingredient_array
    ing_array = self.recipe_ingredients.join(" ").split
    stripped_ing_array = ing_array.collect {|i| i.gsub(/(\W|\d)/, " ")}
    shrunk_array = stripped_ing_array.collect {|i| i.strip.downcase}
    reduced_array = shrunk_array.select {|i| i.length > 2}
  end

  def self.select_by_ingredient_array(array)
    recipes_that_match = []
    array.each do |input|
      self.all.select do |r|
        if r.ingredient_array.include?(input)
          recipes_that_match << r
        end
      end
    end
    recipes_that_match.uniq
  end


end
