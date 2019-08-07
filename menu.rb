class Menu
  attr_reader :name
  def initialize(parent, name)
    @parent = parent
    @name = name
    @options = []
  end

  def show
    puts @name
    puts "Please select an option: ('back' to go back, 'exit' to quit)"
    puts "*" * 50
    @options.each_with_index do |option, index|
      puts "(#{index}) #{option.name}"
    end
    print '> '
  end

  def get_choice
    @choice = gets.chomp
  end

  def run
    loop do
      if @parent.break
        @parent.break = false
        break
      end
      show
      get_choice
      if @choice == 'back'
        break
      elsif @choice == 'exit'
        abort
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
  def initialize(name, command, *args)
    @name = name
    @command = command
    @args = args
  end

  def run
    @command.call(@args[0])
  end

end
