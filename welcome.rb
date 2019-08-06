
# Welcomes user to site
puts "************* Welcome to Group One Car's! *************"
puts "Please select which department you would like:"
puts "1. Inventory\n2. Sales Team\n3. Finance"

# Gets user selection
selection = gets.chomp
# Directs user to appropriate file based on selection
if selection == "1"
  system ("ruby inventory_input.rb")
elsif selection == "2"
  system ("ruby sales_team_input.rb")
elsif selection == "3"
  system ("ruby payments.rb")
else
  puts "ERROR: Please select an availble option"
end
