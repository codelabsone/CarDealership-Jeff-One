require_relative 'dbconnection'
# Accessing the database
db = DbConnection.new('dealership.db')
# Ask the user what they want to filter by
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
elsif option == "2"
  puts "These are the available models you can select:"
  # Making a list from the database of the models
  models = db.list("VehicleModelYear.model")
  # Prints models in database
  models.each do |model_list|
    puts model_list
  end
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
  puts "Please select a range of mileage options:\n1. 0-25,000\n2. 25,001-50,000\n3. 50,001-75,000\n4. 75,001-100,000"
  mile_option = gets.chomp
  if mile_option == "1"
    puts "These are the available vehicles in that range:"
    # Will make a list from the database of the available vehicles
  elsif mile_option == "2"
    puts "These are the available vehicles in that range:"
    # Will make a list from the database of the available vehicles
  elsif mile_option == "3"
    puts "These are the available vehicles in that range:"
    # Will make a list from the database of the available vehicles
  elsif mile_option == "4"
    puts "These are the available vehicles in that range:"
    # Will make a list from the database of the available vehicles
  end
  
end
