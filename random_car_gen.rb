require_relative 'dbconnection'

my_db = DbConnection.new('dealership.db')
vmy_list = my_db.get_vmy()
doors_list = Array(2..5)
engine_cylinders = Array(3..8)
transmission_gears = Array(4..7)
transmission_types = ['manual', 'automatic', 'CVT']
body_styles = ['SUV', 'Coupe', 'Sedan', 'Van', 'Truck', 'Hatchback']
colors_list = ["maroon","red","orange","yellow","olive","green","purple","fuchsia","lime","teal","aqua","blue","navy","black","gray","white","silver"]

car_list = []

for i in 1..3549
  vmy = vmy_list.sample
  # puts vmy
  msrp = rand(500000..5000000) / 100.0
  # puts 'msrp: $%.2f' % msrp
  sale_percent = rand(75..98) / 100.0
  sale_price = msrp * sale_percent
  # puts 'sale price: $%.2f' % sale_price
  is_new = [true, false].sample
  # puts "New: #{is_new}"
  mileage = is_new ? rand(1..20) : rand(800..150000)
  # puts "Mileage: #{mileage}"
  door_count = doors_list.sample
  # puts door_count
  eng_cyl_count = engine_cylinders.sample
  engine_format = (eng_cyl_count % 2 == 1) ? 'I-' : ['I-', 'V-'].sample
  engine_size = Array(35..100).sample * eng_cyl_count / 100.0
  turbo = [true, false].sample ? ' Turbo' : ''
  engine = '%.1f L ' % engine_size + "#{engine_format}#{eng_cyl_count}#{turbo}"
  # puts engine
  transmission_type = transmission_types.sample
  transmission_gear = (transmission_type == 'CVT') ? '' : transmission_gears.sample.to_s + ' speed '
  transmission = transmission_gear + transmission_type
  # puts transmission
  body_style = body_styles.sample
  # puts body_style
  color = colors_list.sample.capitalize
  # puts color
  deal_adjective = ['n amazing', 'n incredible', 'n unbelievable', ' fantastic', ' stupendous'].sample
  color_adjective = ['stunning', 'gorgeous', 'beautiful', 'perfect'].sample
  engine_adjective = ['sporty', 'ecological', 'powerful', 'strong'].sample

  description = "This is a#{deal_adjective} deal on "
  description += (is_new) ? "a new " : "a pre-owned "
  description += "#{door_count}-door #{vmy}. It is a #{color_adjective} #{color}, and "
  description += (is_new) ? "has only been test driven, having only #{mileage}" : "only has #{mileage}"
  description += " miles. This "
  description += "#{body_style} is equipped with a #{transmission} transmission"
  description += " and a #{engine_adjective} #{engine} under the hood. Priced"
  description += " only $#{'%.2f' % sale_price}, #{'%.1f' % ((msrp - sale_price) / msrp * 100)}"
  description += " percent off the MSRP of $#{'%.2f' % msrp}, this #{body_style.downcase}"
  description += " is a steal."

  car_list.append(Car.new(vmy))
  ind = car_list.length - 1
  car_list[ind].msrp = msrp
  car_list[ind].sale_price = sale_price
  car_list[ind].is_new = is_new ? 1 : 0
  car_list[ind].mileage = mileage
  car_list[ind].door_count = door_count
  car_list[ind].engine = engine
  car_list[ind].transmission = transmission
  car_list[ind].body_style = body_style
  car_list[ind].color = color
  car_list[ind].description = description

  # puts "*"*30
end

i = car_list.size
car_list.each do |c|
  puts i
  i -= 1
  my_db.add_car(c)
end
