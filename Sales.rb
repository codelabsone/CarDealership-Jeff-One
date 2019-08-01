# this code is to capture the sales staff

class Sales_Team
  attr_accessor :name, :email, :phone

  def initialize(name, email, phone)
    @name = name
    @email = email
    @phone = phone
  end

  def to_s
    "#{@name}, #{@email}, #{@phone}"
  end
end

class Sales_Team1
  def initialize
    @sales = []
  end

  def add_sales(a_sales)
    @sales << a_sales
  end

  def play
    puts "Meet our sales team:\n "
    @sales.each do |sales|
      puts sales
    end
  end
end

sales1 = Sales_Team.new("Dustin", "Dustin@car.com", "573-225-1234").to_s
sales2 = Sales_Team.new("Debbie", "Debbie@car.com", "573-225-9876").to_s

sales = Sales_Team1.new
sales.add_sales(sales1)
sales.add_sales(sales2)
sales.play
