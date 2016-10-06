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
      find_recipes_with_your_ingredient
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
      view_recipe_in_more_detail(x)
      # puts "here are recipe details"
      # view_recipe_in_more_detail(x)
      menu
    else
      puts "I did not understand your input. Please try again."
    end
  end

  def view_recipe_in_more_detail(selection)
    selection.add_details
    puts ""
    puts "#{selection.recipe_name}"
    puts "Created by #{selection.recipe_author}"
    puts ""
    puts "#{selection.recipe_description}"
    puts ""
    puts ""


    puts "Recipe Ingredients:"
    puts ""
    selection.recipe_ingredients.each {|i| puts "#{i}"}
    puts ""
    puts ""
    puts "Recipe Directions"
    puts ""
    selection.recipe_directions.each.with_index(1) do |step, i|
      puts "#{i}. #{step}"
      puts ""
    end
    puts ""
    puts "The directions for this recipe can also be found at #{selection.recipe_url}. Please visit!"
    puts ""
    puts ""
  end

  def find_recipes_with_your_ingredient
    Recipe.all.each {|r| r.add_details }
    puts ""
    puts "what is your ingredient?"
    input = nil
    input = gets.strip.downcase
    ingredient = make_input_searchable(input)
    list = Recipe.select_by_ingredient_array(ingredient)
    puts "There are #{list.length} recipe(s) that contain the word #{input}."
    puts ""
    puts ""
    list.each.with_index(1) {|r, i| puts "#{i}. #{r.recipe_name}"}
    if list.empty?
      puts "Would you like to try another ingredient? Type yes or no to return to the intial menu."
      input = gets.strip.downcase
      if input == "yes"
        find_recipes_with_your_ingredient
      else
        menu
      end
    else
      puts ""
      puts "To view more information on any of these recipes, type its number."
      puts "Otherwise, type menu to return to the main menu."
      puts ""
      select_recipe(list)
    end
  end


  def make_input_searchable(input)
    (input_array = [] << [input, input+"s", input.sub(/.{1}$/,'')]).flatten
  end

end
