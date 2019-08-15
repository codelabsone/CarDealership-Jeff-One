class VehicleFinanceCalc
  def initialize(car)
    @car = car
  end

  def run
    trade_value = trade_value_prompt
    loan_amount = @car.sale_price - trade_value
    loan_rate = loan_rate_prompt
    loan_term = loan_term_prompt
    payment = calc_payment(loan_amount, loan_rate, loan_term)
    puts "Your estimated monthly payment for the #{@car.year} #{@car.make} #{@car.model}"
    puts "will be $#{'%.2f' % payment} for the information you ented."
  end

  def trade_value_prompt
    trade_value = 0
    loop do
      puts "Will there be a trade in vehicle? (y/n)"
      print "> "
      response = gets.chomp.downcase
      if response == 'y' or response == 'yes'
        trade_value = get_trade_value
        break
      elsif response == 'n' or response == 'no'
        break
      else
        puts "\n\nInvalid entry.\n\n"
        next
      end
    end

    trade_value
  end

  def get_trade_value
    loop do
      puts "Please enter the value of the trade in vehicle."
      print "> "
      trade_value = gets.chomp
      if is_float?(trade_value)
        trade_value = trade_value.to_f
        return trade_value
      else
        puts "\n\nInvalid number entered.\n\n"
      end
    end
  end

  def loan_rate_prompt
    loop do
      puts "What is your expected interest rate for the loan?"
      print "> "
      rate = gets.chomp
      if is_float?(rate)
        rate = rate.to_f
        if rate > 0
          return rate
        end
      end
      puts "Invalid rate entered, please try again."
    end
  end

  def loan_term_prompt
    loop do
      puts "What is the expected length of time for the loan repayment?"
      print "> "
      term = gets.chomp
      if is_int?(term)
        term = term.to_i
        if term > 0
          return term
        end
      end
      puts "Invalid term length entered, please try again."
    end
  end

  def calc_payment(price, rate, term)
    payment = ( ((rate / 12) * price) / (1 - (1 + (rate / 12))**(term * -1) ) )
    payment
  end

  def is_float?(s)
    true if Float(s) rescue false
  end

  def is_int?(s)
    true if Integer(s) rescue false
  end

end
