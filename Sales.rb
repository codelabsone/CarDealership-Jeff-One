# this code is to capture the sales staff

class Sales_People
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

class Sales_Team
  attr_reader :sales

  def initialize
    @sales = []
  end

  def add_sales(a_sales)
    @sales << a_sales
  end
end

sales1 = Sales_Team.new("Dustin", "Dustin@car.com", "573-225-1234").to_s
sales2 = Sales_Team.new("Debbie", "Debbie@car.com", "573-225-9876").to_s

$sales_team = Sales_Team1.new
$sales_team.add_sales(sales1)
$sales_team.add_sales(sales2)
