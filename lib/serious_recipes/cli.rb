class SeriousRecipes::CLI

  def call
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
    puts "you selected 'list'"
  elsif input == "search"
    puts "you selected 'search'"
  elsif input == "exit"
  else
    puts ""
    puts "I did not understand your input. Please try again"
    menu
  end
end

end
