require 'sqlite3'
require_relative 'dbconnection'
require_relative 'filter'

class Vehicle_Type
  def initialize(type)
    @type = type.capitalize
  end

    def type=(new_type)
      @type = new_type.capitalize
    end

    def to_s
      "#{@type}"
    end
end

class Vehicle_Make
  def initialize(make)
    @make = make.capitalize
  end

    def make=(new_make)
      @make = new_make.capitalize
    end

    def to_s
      "#{@make}"
    end
end


db = DbConnection.new('dealership.db')
filters = []
f1 = FilterAlpha.new('make')
f1.value = 'ford'
f2 = FilterAlpha.new('model')
f2.value = 'focus'
f3 = FilterRange.new('mileage')
f3.min, f3.max = 10, 100000
f4 = FilterRange.new('sale_price')
f4.min, f4.max = 5000, 10000

filters.append(f1, f2, f3, f4)

carlist = db.get_cars(filters)
carlist.each do |c|
  puts c
end