require_relative 'menu_header'
require_relative '../models/station'
require_relative '../models/train/train_dispatcher'

module Menu
  # Закрытые функции для вывода информации
  class << self
    def stations_menu
      last_error = ''
      loop do
        begin
          system('clear')

          print_menu_header 'Stations menu'

          puts '1. Show stations list'
          puts '2. Show stations load'
          puts '3. Show stations load by type'
          puts '4. Return'
          puts ''
          puts last_error
          puts 'Enter menu index from keyboard: '

          input = gets.chomp.to_s
          raise TrainManagementException::MenuIndexIncorrectInput if input !~ /^\d{1}\z/

          menu_index = input.to_i
          raise TrainManagementException::MenuIndexOutOfRange unless (1..4).cover? menu_index

          # Если мы здесь значит пользователь ввел корректный номер меню
          last_error = ''
          case menu_index
          when 1
            show_stations_list
          when 2
            show_stations_load
          when 3
            show_stations_load_by_type
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

    private

    def show_stations_list
      system('clear')
      print_menu_header 'Stations list'
      TrainDispatcher.instance.show_stations
      puts ''
      puts 'Press ENTER to continue'
      gets.chomp
    end

    def show_stations_load
      system('clear')
      print_menu_header 'Stations load'
      TrainDispatcher.instance.each_station do |station|
        puts station
        station.each_train do |train|
          puts "  #{train}"
          train.each_carriage { |carriage| puts "    #{carriage}" }
        end
      end
      # TrainDispatcher.instance.show_current_stations_load
      puts ''
      puts 'Press ENTER to continue'
      gets.chomp
    end

    def show_stations_load_by_type
      system('clear')
      print_menu_header 'Stations load by type'
      TrainDispatcher.instance.show_current_stations_load_by_type
      puts ''
      puts 'Press ENTER to continue'
      gets.chomp
    end
  end
end
