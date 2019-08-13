#sale_price = 30000
#int_rate = 0.05
#months = 60

puts "Enter the loan amount:"
sale_price = gets.chomp
sale_price = sale_price.to_f

puts "Enter the loan annual percentage rate using decimals:"
int_rate = gets.chomp
int_rate = int_rate.to_f

puts "Enter the length of the loan in months:"
months = gets.chomp
months = months.to_i

puts "Is there is trade in? (Y or N)"
trade_in = gets.chomp

if trade_in.capitalize == "Y"
  puts "Enter the trade in value:"
  trade_value = gets.chomp
  final_price = sale_price - trade_value.to_f
else
  final_price = sale_price
end

monthly_payment = (((int_rate / 12) * final_price) / (1 - (1 + (int_rate / 12))**(-months)))
puts "Total payments will be #{monthly_payment.round(2)} per month for #{months} months."

# Works down to this point. Rest is in progress.

puts "Would you like a complete amortization table? (Y or N)"
amort_table = gets.chomp


if amort_table.capitalize == "Y"
  puts "Amortization for a #{final_price} loan over #{months} months with an APR of #{int_rate}"
  puts "Payment Number - Principal Payment - Interest Payment - Balance"
  balance = final_price
  1.upto(months) do |m|
    int_payment = balance * (int_rate/12)
    princ_payment = monthly_payment - int_payment
    balance -= princ_payment
    puts "#{m}, #{princ_payment.round(2)}, #{int_payment.round(2)}, #{balance.round(2)}"
  end
end
