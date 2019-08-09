require_relative 'menu'

class PaginatedMenu < Menu

  def initialize(parent, name)
    super
    @current_page = 0
  end

  def show
    start = @current_page * 10
    final = start + 9
    puts @name
    puts "Please select an option:"
    puts "('back' to go back, 'exit' to quit)"
    puts "('p' for previous page, 'n' for next page)"
    puts "*" * 50

    @options[start..final].each_with_index do |option, index|
      puts "(#{index}) #{option.name}"
    end
    print '> '
  end

  def run

    loop do
      start = @current_page * 10
      final = start + 9

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
      elsif @choice == 'p' and @current_page != 0
        @current_page -= 1
        next
      elsif @choice == 'n' and (@current_page + 1) * 10 <= @options.length
        @current_page -= 1
        next
      elsif @choice.to_i < @options[start..final].length
        @options[start..final][@choice].run
      else
        puts "Invalid option entered. Please enter a valid option."
      end

    end

  end

end
