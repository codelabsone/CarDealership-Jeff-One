class Menu

  def initialize(parent, name)
    @parent = parent
    @name = name
  end

  def show
    puts @name
    puts "Please select an option ('quit' to exit):"
    puts "*" * 30
    @options.each_with_index do |option, index|
      puts "(#{index}) #{option.name}"
    end
  end

  def get_choice
    @choice = gets
  end

  def run
    show
    get_choice
    loop do
      if Integer(@choice) < @options.length
        @options[@choice].run
      elsif @choice == 'quit'
        break
      else
        puts "Invalid option entered. Please enter a valid option."
      end
    end
  end

  def add_option(option)
    @option << option
  end

end
