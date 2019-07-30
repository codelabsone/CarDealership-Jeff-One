class Inventory
  attr_reader :year, :make, :model, :mileage

  def initialize(year, make, model, mileage)
    @year = year
    @make = make
    @model = model
    @mileage = mileage
  end

  def to_s
    "#{@year} #{@make} #{@model} with #{@mileage} miles"
  end
end

class Show_Inventory
  def initialize
    @inventory = []
  end

  def add_vehicle(vehicle)
    @inventory << vehicle
  end

  def show_inv
    puts "The following vehicles are available:"

    @inventory.each do |avail_inv|
      puts avail_inv
    end
  end
end

inventory = Show_Inventory.new
inventory.add_vehicle(car1)
inventory.add_vehicle(car2)
inventory.show_inv
