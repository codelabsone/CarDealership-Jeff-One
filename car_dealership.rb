require 'sqlite3'
require_relative 'dbconnection'
require_relative 'filter'
require_relative 'menu'
require_relative 'Sales'

class DealershipApp

  attr_accessor :filters, :break

  def initialize(name)
    @name = name
    @db = DbConnection.new('dealership.db')
    @filters = []
    @sales_team = []
    load_sales_team('sales.csv')
    @sales_team_menu = create_sales_team_menu
    @main_menu = Menu.new(self, "Main Menu")
    @inventory_menu = create_inventory_menu
    @main_menu.add_option(@inventory_menu)
    @main_menu.add_option(@sales_team_menu)
  end

  def create_filter_menu(parent)
    filter_menu = Menu.new(parent, "Add Filters")
    filter_menu.add_option(FilterNameInput.new(self, 'make'))
    filter_menu.add_option(FilterNameInput.new(self, 'model'))
    filter_menu.add_option(FilterRangeInput.new(self, 'year'))
    filter_menu.add_option(FilterRangeInput.new(self, 'mileage'))
    filter_menu
  end

  def create_inventory_menu
    inventory_menu = Menu.new(self, "Inventory Search")
    filters_menu = create_filter_menu(inventory_menu)
    inventory_menu.add_option(filters_menu)

    inventory_menu.add_option(MenuCommand.new("List Filters", Proc.new { list_filters }))
    inventory_menu
  end

  def list_filters
    puts "These are the current chosen filters"
    @filters.each do |filter|
      puts filter
    end
    puts "\n"
  end

  def create_sales_team_menu
    sales_team_menu = Menu.new(self, "Sales Team")
    @sales_team.each do |member|
      sales_team_menu.add_option(MenuCommand.new(member.name, Proc.new {|m| show_sales_member(m)}, member))
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
    clear_screen
    @main_menu.run
  end

  def clear_screen
    puts "Going to clear the screen"
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
