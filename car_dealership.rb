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
f3 = FilterRange.new('mileage')
f3.min, f3.max = 1000, 2000

filters.append(f3)

carlist = db.get_cars(filters)
carlist.each do |c|
  puts "#{c}: #{c.mileage}"
end
