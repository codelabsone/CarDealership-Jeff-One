class Vmy
  attr_reader :year
  attr_reader :make
  attr_reader :model
  attr_accessor :id

  def initialize(year, make, model)
    @make = make
    @model = model
    @year = year
  end

  def to_s
    "#{@year} - #{@make} #{@model}"
  end
end
