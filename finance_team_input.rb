# Will require a Finance team file

puts "************ Group One Car's Finance Team ************"
puts "Please select what you would like to do:\n1. Finance Team\n2. Payment Calculator"
puts "Press 9 to return to the main menu"

finance_choice = gets.chomp
# will show the finance associates
if finance_choice == '1'
#   puts ""
elsif finance_choice == '2'
  system ("ruby payments.rb")
else finance_choice == '9'
  system ("ruby welcome.rb")
end 
