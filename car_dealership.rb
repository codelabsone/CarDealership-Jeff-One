require 'sqlite3'
require_relative 'dbconnection'
require_relative 'filter'
require_relative 'menu'

class DealershipApp

  attr_accessor :filters

  def initialize(name)
    @name = name
    @db = DbConnection.new('dealership.db')
    @filters = []
    @main_menu = Menu.new(self, "Main Menu")
    @inventory_menu = create_inventory_menu

    main_menu.add_option(inventory_menu)
  end

  def create_inventory_menu
    inventory_menu = Menu.new(self, "Inventory Search")
    inventory_menu.add_option(FilterNameInput.new('make'))
    inventory_menu.add_option(FilterNameInput.new('model'))
    inventory_menu.add_option(FilterRangeInput.new('year'))
    inventory_menu.add_option(FilterRangeInput.new('mileage'))
    inventory_menu
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
