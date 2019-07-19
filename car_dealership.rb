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
  def initialize(option)
    @option = option
    @type = []
    @make = []
  end

  def add_type(type)
    @type << type
  end

  def add_make(make)
    @make << make
  end

  def play
    puts "The following #{@option} are available:"
    puts @types
    puts @make

    @type.each do |types|
      puts types
    end

    @make.each do |make|
      puts make
    end
  end
end

type1 = Vehicle_Type.new("SUV")
type2 = Vehicle_Type.new("truck")
type3 = Vehicle_Type.new("car")
type4 = Vehicle_Type.new("van")

filter1 = Filter.new("vehicle types")
filter1.add_type(type1)
filter1.add_type(type2)
filter1.add_type(type3)
filter1.add_type(type4)
filter1.play

make1 = Vehicle_Make.new("ford")
make2 = Vehicle_Make.new("chevrolet")

filter2 = Filter.new("vehicle makes")
filter2.add_make(make1)
filter2.add_make(make2)

filter2.play
