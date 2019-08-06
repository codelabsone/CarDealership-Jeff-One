require_relative 'Sales.rb'
sales_team = $sales_team

puts "************ Group One Car's Sales Team ************"
puts "Please select which Sales Team associate you'd like to contact:\n1. #{sales_team.sales[0]} \n2. #{sales_team.sales[1]}"
puts "Press 9 to return to the main menu"
# Getting user input
sales_choice = gets.chomp

# if sales_choice == '1'
#   puts "To contact #{Sales_Team.index[0]} please call"
