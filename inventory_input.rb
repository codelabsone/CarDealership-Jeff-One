require 'sqlite3'
require_relative 'dbconnection'
require_relative 'filter'
# Accessing the database
db = DbConnection.new('dealership.db')
# Ask the user what they want to filter by
puts "************ Group One Car's Inventory ************"
puts "Please select what you'd like to filter by:\n1. Make\n2. Model\n3. Year\n4. Mileage"
#gets the users input
option = gets.chomp
#returns the appropriate option based on the users input
if option == "1"
  puts "These are the available makes you can select:"
  # Making a list from the database of the makes
  makes = db.list("VehicleModelYear.make")
  # Prints makes in databse
  makes.each do |make_list|
    puts make_list
  end
# User inputs the make they want to search by
  select_make = gets.chomp
  make_filter = FilterAlpha.new("make")
  make_filter.value = select_make
# Returns a list of the selected models available for the selected make of vehicle
  models = db.get_models(make_filter)
  models.each do |model|
    puts "The following models are available for #{select_make}:\n#{model}"
  end
elsif option == "2"
  puts "These are the available models you can select:"
# Making a list from the database of the models
  models = db.list("VehicleModelYear.model")
# Prints models in database
  models.each do |model_list|
    puts model_list
  end
#User inputs the model they want to search by
  # select_model = gets.chomp
  # model_filter = FilterAlpha.new("model")
  # model_filter.value = select_model
# Returns a list of the selected vehicles that are availble in the selected model
#
elsif option == "3"
  puts "These are the available years you can select:"
  # Making a list from the databse of the years
  years = db.list("VehicleModelYear.year")
  # Prints years in database
  years.each do |year_list|
    puts year_list
  end
elsif option == "4"
  # Creates a new list of options from which the user chooses their range and gets their selection
  puts "Please select a range of mileage options:\n1. 0-25,000\n2. 25,001-50,000\n3. 50,001-75,000\n4. 75,001-100,000\n5. 100,000+"
  mile_option = gets.chomp

  if mile_option == "1"
    min = 0
    max = 25000
  elsif mile_option == "2"
    min = 25001
    max = 50000
  elsif mile_option == "3"
    min = 50001
    max = 75000
  elsif mile_option == "4"
    min = 75001
    max = 100000
  elsif mile_option == "5"
    min = 100000
    max = 100000000
  else
    puts "ERROR: Please choose an available option."
  end
  # Returns vehicles in chosen mileage ranges
  mile_filter = FilterRange.new("mileage")
  mile_filter.min, mile_filter.max = min, max
  mile_list = db.get_cars(mile_filter)
  puts "These are the available vehicles in that range:"
  mile_list.each do |list|
    puts list
  end
else
  puts "ERROR: Please choose an available option."

end




#to cennect files from a welcome page system("file name")
