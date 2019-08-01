# Welcomes user to site
puts "************* Welcome to Group One Car's! *************"
puts "Please select which department you would like:"
puts "1. Inventory\n2. Sales Team\n3. Finance"

# Gets user selection
selection = gets.chomp
# Directs user to appropriate file based on selection
if selection == "1"
  system ("filter_input")
elsif selection == "2"
  # Will enter path for Sales Team file
elsif selection == "3"
  # Will enter path for Finance file
else
  puts "ERROR: Please select an availble option"
end
