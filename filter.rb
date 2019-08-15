
class Filter
  def initialize(name)
    @name = name
  end

  def length
    1
  end

end

class FilterName < Filter
  attr_accessor :value

  def to_s
    "#{@name.capitalize} of #{@value.capitalize}"
  end

  def clause
    " #{@name.downcase}='#{@value.capitalize}'"
  end
end

class FilterRange < Filter
  attr_accessor :min, :max
  def to_s
    "#{@name.capitalize} between #{@min} and #{@max}"
  end

  def clause
    " #{@name.downcase} BETWEEN #{@min} AND #{@max}"
  end
end

class FilterInput
  attr_reader :name

  def initialize(parent, name)
    @parent = parent
    @name = name
  end

  def add_to_parent(filter)

    if @parent.filters[@name].is_a? Array
      @parent.filters[@name] << filter
    else
      @parent.filters[@name] = Array.new()
      @parent.filters[@name] << filter
    end
  end

end

class FilterNameInput < FilterInput

  def run
    puts "Enter the #{@name} you want to look for: "
    print "> "
    filter_value = gets.chomp
    f = FilterName.new(@name)
    f.value = filter_value
    add_to_parent(f)
  end

end

class FilterRangeInput < FilterInput

  def run
    puts "Enter the minimum #{@name} you want: "
    print "> "
    min = gets.chomp
    puts "Enter the maxiumum #{@name} you want: "
    print "> "
    max = gets.chomp
    min = (min == '') ? 0 : min.to_i
    max = (max == '') ? 1000000 : max.to_i
    f = FilterRange.new(@name)
    f.min = min
    f.max = max
    add_to_parent(f)
  end

end
