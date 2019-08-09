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
    puts "Page: #{@current_page}"

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
      elsif @choice == 'p'
        if @current_page != 0
          @current_page -= 1
        else
          puts "No previous page"
        end
        next
      elsif @choice == 'n'
        if(@current_page + 1) * 10 <= @options.length
          @current_page += 1
        else
          puts "No next page"
        end
        next
      elsif is_int?(@choice)
        if @choice.to_i < @options[start..final].length
          @options[start..final][@choice.to_i].run
        else
          puts "\nInvalid option entered. Please enter a valid option.\n"
        end
      else
        puts "\nInvalid option entered. Please enter a valid option.\n"
      end

    end

  end

end
