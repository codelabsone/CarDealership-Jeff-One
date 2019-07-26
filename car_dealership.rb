require 'sqlite3'
require_relative 'dbconnection'

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

class Filter
  def initialize(name)
    @name = name
    @options = []
  end

  def add_option(option)
    @options << option
  end

  def to_s
    ret = "These #{@name}s are available:"
    @options.each do |option|
      ret += "\n" + option.to_s
    end
    ret
  end
end

db = DbConnection.new('dealership.db')
table = 'VehicleModelYear'
options = ["year", "make", "model"]

options.each do |option|
  c = db.count(table + '.' + option)
  puts "#{table}.#{option} has #{c} distinct entries."
end

#
# TBL = "VehicleModelYear"
#
# query = db.prepare "SELECT DISTINCT(make) FROM '#{TBL}';"
# result = query.execute
#
# result.each do |r|
#   puts r
# end

# types = []
# types << Vehicle_Type.new("SUV")
# types << Vehicle_Type.new("truck")
# types << Vehicle_Type.new("car")
# types << Vehicle_Type.new("van")
#
# filter1 = Filter.new("Body Style")
# types.each do |type|
#   filter1.add_option(type)
# end
#
# makes = []
# makes << Vehicle_Make.new("ford")
# makes << Vehicle_Make.new("chevrolet")
# makes << Vehicle_Make.new("toyota")
# makes << Vehicle_Make.new("dodge")
# makes << Vehicle_Make.new("chrysler")
#
# filter2 = Filter.new("make")
# makes.each do |make|
#   filter2.add_option(make)
# end
#
# puts filter1
#
# puts filter2
