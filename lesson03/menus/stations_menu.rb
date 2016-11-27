require_relative 'menu_header'
require_relative '../models/station'
require_relative '../models/train/train_dispatcher'

module Menus
  def Menus.StationsMenu
    last_error = ''

    loop do
      begin
        system('clear')

        Menus::PrintMenuHeader('Stations menu')

        puts '1. Show stations list'
        puts '2. Show stations load'
        puts '3. Show stations load by type'
        puts '4. Return'
        puts ''
        puts last_error
        puts 'Enter menu index from keyboard: '

        input = gets.chomp.to_s
        raise TrainManagementException::MenuIndexIncorrectInput if input !~ /^\d{1}\z/

        menuIndex = input.to_i
        raise TrainManagementException::MenuIndexOutOfRange if !(1..4).include? menuIndex

        # Если мы здесь значит пользователь ввел корректный номер меню
        last_error = ''
        case menuIndex
          when 1
            Menus::ShowStationsList()
          when 2
            Menus::ShowStationsLoad()
          when 3
            Menus::ShowStationsLoadByType()
          when 4
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

  # Закрытые функции для вывода информации
  private

  def Menus.ShowStationsList
    system('clear')
    Menus::PrintMenuHeader('Stations list')
    TrainDispatcher.default.show_stations
    puts ''
    puts 'Press ENTER to continue'
    gets.chomp
  end

  def Menus.ShowStationsLoad
    system('clear')
    Menus::PrintMenuHeader('Stations load')
    TrainDispatcher.default.show_current_stations_load
    puts ''
    puts 'Press ENTER to continue'
    gets.chomp
  end

  def Menus.ShowStationsLoadByType
    system('clear')
    Menus::PrintMenuHeader('Stations load by type')
    TrainDispatcher.default.show_current_stations_load_by_type
    puts ''
    puts 'Press ENTER to continue'
    gets.chomp
  end

end