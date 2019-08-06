class Menu
  attr_reader :name
  def initialize(parent, name)
    @parent = parent
    @name = name
    @options = []
  end

  def show
    puts @name
    puts "Please select an option ('quit' to exit):"
    puts "*" * 50
    @options.each_with_index do |option, index|
      puts "(#{index}) #{option.name.capitalize}"
    end
  end

  def get_choice
    @choice = gets.chomp
    # puts "#{@choice} in get_choice"
  end

  def run
    loop do
      show
      get_choice
      if @choice == 'quit'
        # puts "quitting"
        break
      elsif @choice.to_i < @options.length
        @options[@choice.to_i].run
      else
        puts "Invalid option entered. Please enter a valid option."
      end
    end
  end

  def add_option(option)
    @options << option
  end

end

class MenuCommand
  attr_reader :name
  def initialize(name, command)
    @name = name
    @command = command
  end

  def run
    @command.call
  end

end
