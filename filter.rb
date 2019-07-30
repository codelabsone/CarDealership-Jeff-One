
class Filter
  def initialize(name)
    @name = name
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
