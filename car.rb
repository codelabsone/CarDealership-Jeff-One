class Car

  attr_accessor :msrp
  attr_accessor :sale_price
  attr_accessor :is_new
  attr_accessor :mileage
  attr_accessor :door_count
  attr_accessor :engine
  attr_accessor :transmission
  attr_accessor :body_style
  attr_accessor :color
  attr_accessor :description
  attr_reader :year, :make, :model

  def initialize(vmy)
    @year = vmy.year
    @make = vmy.make
    @model = vmy.model
  end

  def sale_percent
    msrp - sale_price / 100.0
  end

  def to_s
    "#{@color.ljust(10)} #{@vmy.year.to_s.ljust(6)} #{@vmy.make.ljust(10)} #{@vmy.model}"
  end

end
