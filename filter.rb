
class Filter
  def initialize(name)
    @name = name
  end

  def length
    1
  end

end

class FilterAlpha < Filter
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

  def initialize(parent, name)
    @parent = parent
    @name = name
  end

end

class FilterNameInput < FilterInput

  def run
    puts "Enter the #{@name} you want to look for: "
    filter_value = gets.chomp
    @parent.filters << FilterAlpha.new(@name, filter_value.capitalize)
  end

end

class FilterRangeInput < FilterInput

  def run
    puts "Enter the minimum #{@name} you want: "
    min = gets.chomp
    puts "Enter the maxiumum #{@name} you want: "
    max = gets.chomp
    min = (min == '') ? 0 : min.to_i
    max = (max == '') ? 1000000 : max.to_i
    @parent.filters << FilterRange.new(@name, min, max)
  end

end
