require_relative 'menu_header'
require_relative 'stations_menu'
require_relative 'trains_menu'

module Menus
  def Menus.MainMenu
    last_error = ''

    loop do
      begin
        system('clear')

        Menus::PrintMenuHeader()

        puts '1. Station menu'
        puts '2. Train menu'
        puts '3. Exit'
        puts ''
        puts last_error
        puts 'Enter menu index from keyboard: '

        input = gets.chomp.to_s
        raise TrainManagementException::MenuIndexIncorrectInput if input !~ /^\d{1}\z/

        menuIndex = input.to_i
        raise TrainManagementException::MenuIndexOutOfRange if !(1..3).include? menuIndex

        # Если мы здесь значит пользователь ввел корректный номер меню
        last_error = ''
        case menuIndex
          when 1
            Menus::StationsMenu()
          when 2
            Menus::TrainsMenu()
          when 3
            puts 'Thank you for using our software. Good bye!'
            break
        end

      rescue TrainManagementException::MenuIndexIncorrectInput
        last_error = 'You input incorrect index, please try again'
        retry
      rescue TrainManagementException::MenuIndexOutOfRange
        last_error = 'Index is not present in menu, please input correct index.'
        retry
      end
    end
  end
end