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

sales1 = Sales_People.new("Dustin", "Dustin@car.com", "573-225-1234")
sales2 = Sales_People.new("Debbie", "Debbie@car.com", "573-225-9876")

$sales_team = Sales_Team.new
$sales_team.add_sales(sales1)
$sales_team.add_sales(sales2)
