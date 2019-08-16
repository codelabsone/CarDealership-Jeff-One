require 'sqlite3'
require_relative 'dbconnection'
require_relative 'filter'
require_relative 'menu'
require_relative 'paginated_menu'
require_relative 'Sales'
require_relative 'vehicle_finance_calc'

class DealershipApp

  attr_accessor :filters, :break

  def initialize(name)
    clear_screen
    @name = name
    @db = DbConnection.new('dealership.db')
    @filters = Hash.new()
    @sales_team = []
    load_sales_team('sales.csv')

    @sales_team_menu = create_sales_team_menu
    @inventory_menu = create_inventory_menu

    @main_menu = Menu.new(self, "Main Menu")
    @main_menu.add_option(@inventory_menu)
    @main_menu.add_option(@sales_team_menu)
  end

  # def create_add_filter_menu
  #   add_filter_menu = Menu.new(self, "Add Filters")
  #   add_filter_menu.add_option(FilterNameInput.new(self, 'make'))
  #   add_filter_menu.add_option(FilterNameInput.new(self, 'model'))
  #   add_filter_menu.add_option(FilterRangeInput.new(self, 'year'))
  #   add_filter_menu.add_option(FilterRangeInput.new(self, 'mileage'))
  #   add_filter_menu.add_option(FilterRangeInput.new(self, 'sale_price'))
  #   add_filter_menu.add_option(FilterNameInput.new(self, 'color'))
  #   add_filter_menu
  # end

  def create_add_filter_menu
    add_filter_menu = Menu.new(self, "Add Filters")

    make_menu = PaginatedMenu.new(self, "Make Filter")
    make_list = @db.list("VehicleModelYear.make")
    make_list.each do |make|
      make_menu.add_option(MenuCommand.new(make, Proc.new { |type, value| add_name_filter(type, value) }, 'make', make))
    end
    add_filter_menu.add_option(make_menu)

    model_menu = PaginatedMenu.new(self, "Model Filter")
    model_list = @db.list("VehicleModelYear.model")
    model_list.each do |model|
      model_menu.add_option(MenuCommand.new(model, Proc.new { |type, value| add_name_filter(type, value)}, 'model', model))
    end
    add_filter_menu.add_option(model_menu)

    color_menu = PaginatedMenu.new(self, "Color Filter")
    color_list = @db.list("inventory.color")
    color_list.each do |color|
      color_menu.add_option(MenuCommand.new(color.capitalize, Proc.new { |type, value| add_name_filter(type, value)}, 'color', color))
    end
    add_filter_menu.add_option(color_menu)

    add_filter_menu
  end

  def add_name_filter(type, value)
    f = FilterName.new(type)
    f.value = value
    if @filters[type].is_a? Array
      @filters[type] << f
    else
      @filters[type] = Array.new()
      @filters[type] << f
    end
  end


  def create_filter_menu
    filter_menu = Menu.new(self, "Filters")
    filter_menu.add_option(create_add_filter_menu)
    filter_menu.add_option(MenuCommand.new("List Filters", Proc.new { list_filters }))
    filter_menu.add_option(MenuCommand.new("Remove Filters", Proc.new { create_remove_filters_command}))
    filter_menu
  end

  def create_remove_filters_command
    create_remove_filters.run
  end

  def create_remove_filters
    remove_filters = PaginatedMenu.new(self, "Remove filters")
    @filters.keys.each do |key|
      @filters[key].each do |filter|
        remove_filters.add_option(MenuCommand.new(filter.to_s, Proc.new { |key, filter| remove_filter(key, filter)}, key, filter))
      end
    end
    remove_filters
  end

  def remove_filter(key, filter)
    @filters[key].delete(filter)
    @break = true
  end

  def create_inventory_menu
    inventory_menu = Menu.new(self, "Inventory")
    filters_menu = create_filter_menu
    view_inventory = MenuCommand.new("View Inventory", Proc.new {view_inventory_menu_command} )
    inventory_menu.add_option(filters_menu)
    inventory_menu.add_option(view_inventory)
    inventory_menu
  end

  def create_car_menu(car)
    m = Menu.new(self, "#{car.year} #{car.make} #{car.model}")
    details = MenuCommand.new("View Details", Proc.new {|c| show_car_details(c)}, car)
    finance = MenuCommand.new("Finance", Proc.new{|c| finance_car(c)}, car)

    m.add_option(details)
    m.add_option(finance)
    m
  end

  def show_car_details(car)
    puts "\n#{car.year} #{car.make} #{car.model} - $#{car.sale_price}"
    puts "Color: #{car.color}"
    puts "Mileage: #{car.mileage}"
  end

  def finance_car(car)
    financing = VehicleFinanceCalc.new(car)
    financing.run
  end

  def view_inventory_menu_command
    view_inventory_menu.run
  end

  def view_inventory_menu
    view_inventory = PaginatedMenu.new(self, "View Inventory")
    car_list = @db.get_cars(@filters)
    car_list.each do |car|
      view_inventory.add_option(create_car_menu(car))
    end
    view_inventory
  end

  def list_filters
    puts "These are the current chosen filters"
    @filters.keys.each do |key|
      @filters[key].each do |filter|
        puts filter
      end
    end
    puts "\n"
  end

  def remove_filter_menu_command

  end

  def create_sales_team_menu
    sales_team_menu = Menu.new(self, "Sales Team")
    @sales_team.each do |member|
      sales_team_menu.add_option(MenuCommand.new(member.name, Proc.new {|member| show_sales_member(member)}, member))
    end
    sales_team_menu
  end

  def show_sales_member(member)
    puts "\nName: #{member.name}"
    puts "Email: #{member.email}"
    puts "Phone: #{member.phone}\n"
    @break = true
  end

  def load_sales_team(file_name)
    File.readlines(file_name).each do |line|
      @sales_team << Sales_Person.from_csv(line)
    end
  end

  def run
    @main_menu.run
  end

  def clear_screen
    if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
      system('cls')
    else
      system('clear')
    end
  end

end

# db = DbConnection.new('dealership.db')
# filters = []
# f3 = FilterRange.new('mileage')
# f3.min, f3.max = 1000, 2000
#
# filters.append(f3)
#
# carlist = db.get_cars(filters)
# carlist.each do |c|
#   puts "#{c}: #{c.mileage}"
# end

app = DealershipApp.new("JeffGroupOne")

app.run
