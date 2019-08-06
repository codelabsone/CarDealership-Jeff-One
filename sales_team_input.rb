require_relative 'Sales.rb'
sales_team = $sales_team

puts "************ Group One Car's Sales Team ************"
puts "Please select which Sales Team associate you'd like to contact:\n1. #{sales_team.sales[0].name} \n2. #{sales_team.sales[1].name}"
puts "Press 9 to return to the main menu"
# Getting user input
sales_choice = gets.chomp

if sales_choice == '1'
  puts "To contact #{sales_team.sales[0].name}\ncall #{sales_team.sales[0].phone}\nemail #{sales_team.sales[0].email}"
elsif sales_choice == '2'
  puts "To contact #{sales_team.sales[1].name}\ncall: #{sales_team.sales[1].phone}\nemail: #{sales_team.sales[1].email}"
else sales_choice == '9'
  system ("ruby welcome.rb")
end
