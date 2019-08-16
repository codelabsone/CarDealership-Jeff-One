class Menu
  ##############################################################################
  #
  #   Menu object, has a parent object (what object it belongs to), name, and options
  #
  ##############################################################################
  attr_reader :name
  attr_accessor :break
  def initialize(parent, name)
    @parent = parent
    @name = name
    @options = []
    @break = false
  end

  def show
    #################################################
    #
    #   list options with their index number
    #   can refactor to use hashes/keys instead
    #
    #################################################
    puts "\n"
    puts "*" * 70
    puts "#{@name}"
    puts "Please select an option: ('back' to go back, 'exit' to quit)"
    puts "*" * 70
    @options.each_with_index do |option, index|
      puts "(#{index}) #{option.name}"
    end
    print '> '
  end

  def get_choice
    @choice = gets.chomp
  end

  def is_int?(s)
    true if Integer(s) rescue false
  end

  def run
    #################################################
    #
    #   runs a loop for the current menu
    #
    #################################################
    loop do

      # check if previous option caused a break to previous menu
      if @parent.break
        @parent.break = false
        break
      end

      #print options and get user choice
      show
      get_choice

      if @choice == 'back' # return to previous menu by breaking out of this loop
        break
      elsif @choice == 'exit' # exit program
        abort
      elsif is_int?(@choice)
        if @choice.to_i < @options.length # run the option from the desired input
          @options[@choice.to_i].run
        else
          puts "\nInvalid option entered. Please enter a valid option."
        end
      else
        puts "\nInvalid option entered. Please enter a valid option.\n"
      end
    end
  end

  def add_option(option)
    @options << option
  end

end

class MenuCommand
  #################################################
  #
  #    Menu item that just runs a command
  #
  #################################################
  attr_reader :name
  def initialize(name, command, *args)
    #################################################
    #
    # command is a Proc object that holds a function,
    # which is executed with the call method
    #
    # *args contains any arguments that need to be
    # passed into the command
    #
    #################################################
    @name = name
    @command = command
    @args = args
  end

  def run
    if @args.length == 1 # check if only one argument is being passed
      @args = @args[0] # set the args variable to be the only argument if so
    end
    @command.call(@args) # execute the command, passing the argument(s)
  end

end
