require_relative 'menu_header'
require_relative '../models/train/passenger_train'
require_relative '../models/train/cargo_train'
require_relative '../exceptions/train_management_exception'

module Menus
  def Menus.TrainsMenu
    last_error = ''

    loop do
      begin
        system('clear')

        Menus::PrintMenuHeader('Trains menu')

        puts '1. Create train'
        puts '2. Return'
        puts ''
        puts last_error
        puts 'Enter menu index from keyboard: '

        input = gets.chomp.to_s
        raise TrainManagementException::MenuIndexIncorrectInput if input !~ /^\d{1}\z/

        menuIndex = input.to_i
        raise TrainManagementException::MenuIndexOutOfRange if !(1..2).include? menuIndex

        # Если мы здесь значит пользователь ввел корректный номер меню
        last_error = ''
        case menuIndex
          when 1
            Menus::CreateTrain()
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

  # Закрытый раздел для обработки действий меню
  private

  def Menus::CreateTrain
    system('clear')
    last_error = ''
    begin
      Menus::PrintMenuHeader('Input train number')
      puts last_error
      puts 'Examples: s4s-5n, 234-m2, 234ns'
      number = gets.chomp.to_s
      Menus::SelectTrainType(number)
    rescue TrainManagementException::AttributeNameValidationRuleError => e
      last_error = 'Incorrect train number, please try again' if e.attribute_name == :number
      retry
    end

    puts ''
    puts 'Press ENTER to continue'
    gets.chomp
  end

  def Menus::SelectTrainType(train_number)
    last_error = ''
    loop do
      begin
        system('clear')

        Menus::PrintMenuHeader('Select train type')
        puts '1. Passenger train'
        puts '2. Cargo train'
        puts '3. Cancel'
        puts ''
        puts last_error
        puts 'Enter menu index from keyboard: '

        input = gets.chomp.to_s
        raise TrainManagementException::MenuIndexIncorrectInput if input !~ /^\d{1}\z/

        menuIndex = input.to_i
        raise TrainManagementException::MenuIndexOutOfRange if !(1..3).include? menuIndex

        # Если мы здесь значит пользователь ввел корректный номер меню
        last_error = ''
        result = nil
        case menuIndex
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