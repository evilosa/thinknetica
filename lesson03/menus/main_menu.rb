module Menus
  def main_menu
    last_error = '';

    loop do
      begin
        system('clear')

        print_menu_header
        puts '1. Station menu'
        puts '2. Train menu'
        puts '3. Exit'
        puts ''
        puts last_error
        puts 'Enter menu index from keyboard: '

        input = gets.chomp.to_s
        raise 'Incorrect input' if input !~ /^\d{1}\z/

        menuIndex = input.to_i
        raise 'Out of range' if !(1..3).include? menuIndex

        # Если мы здесь значит пользователь ввел корректный номер меню
        last_error = ''
        case menuIndex
          when 1
            station_menu
          when 2
            station_menu
          when 3
            break
        end

      rescue
        last_error = 'You input incorrect index, please try again.'
        retry
      end
    end
  end
end