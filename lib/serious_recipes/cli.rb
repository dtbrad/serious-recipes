require 'pry'
class SeriousRecipes::CLI

  def call
    Recipe.make_recipes
    greeting
    menu
  end

  def greeting
    puts ""
    puts ""
    puts "                     WELCOME TO SERIOUS RECIPES."
    puts ""
    puts "This gem allows you to view and search by ingredient for the latest recipes from the Serious Eats website."
  end

  def menu
    input=nil
    puts ""
    puts ""
    puts "Initial Menu"
    puts ""
    puts "Please select from the following options:"
    puts ""
    puts "Type list to list Recipes."
    puts "Type search to search for a recipe by ingredient."
    puts "Type exit to leave the program"
    puts ""
    input=gets.strip.downcase

    if input == "list"
      view_recipes
      select_recipe(Recipe.all)
    elsif input == "search"
      puts "you selected 'search'"
    elsif input == "exit"
    else
      puts ""
      puts "I did not understand your input. Please try again"
      menu
    end
  end

  def view_recipes
    puts ""
    puts "Latest Recipes List"
    puts ""
    Recipe.all.each.with_index(1) do |r, i|
      puts "#{i}. #{r.recipe_name}."
      puts ""
    end
    puts ""
    puts "Enter the number of the recipe you'd like more information on, or type menu to return to the main menu:"
    puts ""
  end

  def select_recipe(array)
    input=nil
    input=gets.strip.downcase
    if input == "menu"
      menu
    elsif input.to_i.between?(1, array.length)
      x = array[input.to_i-1]
      puts "here are recipe details"
      menu
    else
      puts "I did not understand your input. Please try again."
    end
  end

end
