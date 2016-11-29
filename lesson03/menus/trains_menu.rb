require_relative 'menu_header'
require_relative '../models/train/passenger_train'
require_relative '../models/train/cargo_train'
require_relative '../exceptions/train_management_exception'

module Menu
  class << self
    def trains_menu
      last_error = ''
      loop do
        begin
          system('clear')

          print_menu_header 'Trains menu'

          puts '1. Create train'
          puts '2. Return'
          puts ''
          puts last_error
          puts 'Enter menu index from keyboard: '

          input = gets.chomp.to_s
          raise TrainManagementException::MenuIndexIncorrectInput if input !~ /^\d{1}\z/

          menu_index = input.to_i
          raise TrainManagementException::MenuIndexOutOfRange unless (1..2).cover? menu_index

          # Если мы здесь значит пользователь ввел корректный номер меню
          last_error = ''
          case menu_index
          when 1
            create_train
          when 2
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

    def create_train
      system('clear')
      last_error = ''
      begin
        print_menu_header 'Input train number'
        puts last_error
        puts 'Examples: s4s-5n, 234-m2, 234ns'
        number = gets.chomp.to_s
        select_train_type number
      rescue TrainManagementException::AttributeNameValidationRuleError => e
        last_error = 'Incorrect train number, please try again' if e.attribute_name == :number
        retry
      end

      puts ''
      puts 'Press ENTER to continue'
      gets.chomp
    end

    def select_train_type(train_number)
      last_error = ''
      loop do
        begin
          system('clear')

          print_menu_header 'Select train type'
          puts '1. Passenger train'
          puts '2. Cargo train'
          puts '3. Cancel'
          puts ''
          puts last_error
          puts 'Enter menu index from keyboard: '

          input = gets.chomp.to_s
          raise TrainManagementException::MenuIndexIncorrectInput if input !~ /^\d{1}\z/

          menu_index = input.to_i
          raise TrainManagementException::MenuIndexOutOfRange unless (1..3).cover? menu_index

          # Если мы здесь значит пользователь ввел корректный номер меню
          last_error = ''
          result = nil
          case menu_index
          when 1
            result = PassengerTrain.new(number: train_number)
          when 2
            result = CargoTrain.new(number: train_number)
          end
          puts result unless result.nil?
          break # Пользователь определился с моделью, возвращаемся в любом случае

        rescue TrainManagementException::MenuIndexIncorrectInput
          last_error = 'You input incorrect index, please try again'
          retry
        rescue TrainManagementException::MenuIndexOutOfRange
          last_error = 'Index is not present in menu, please input correct index.'
          retry
        rescue StandardError => e
          puts e.message
          break
        end
      end
    end
  end
end
