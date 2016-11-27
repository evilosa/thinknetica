require_relative '../../modules/manufacturer'
require_relative '../../modules/instance_counter'
require_relative '../../modules/number_searchable'
require_relative 'train_dispatcher'
require_relative '../railway_carriage/passenger_railway_carriage'
require_relative '../railway_carriage/cargo_railway_carriage'
require_relative '../../modules/validation'

class Train
  include Manufacturer
  include InstanceCounter

  # >> Lesson 05
  include NumberSearchable
  # << Lesson 05

  # >> Lesson 06
  include Validation

  NUMBER_FORMAT = /^\w\w\w-?\w\w\z/
  # >> Validation rules
  add_value_type_validation_rule(:dispatcher, TrainDispatcher)
  add_value_format_validation_rule(:number, NUMBER_FORMAT)
  # << Validation rules
  # << Lesson 06


  attr_accessor :speed

  attr_reader :route, :dispatcher, :current_station

  def initialize(dispatcher: TrainDispatcher.default, number: '0001')
    @dispatcher = dispatcher
    @speed = 0
    self.number = number
    @railway_carriages = []

    register_item!
    register_instance!


    validate!
  end

  # Может набирать скорость
  def accelerate(speed)
    self.speed += speed
  end

  # Может показывать текущую скорость
  def show_current_speed
    puts "Current speed: #{speed} km/h"
  end

  # Может тормозить (сбрасывать скорость до нуля)
  def stop
    self.speed = 0
  end

  # Может показывать количество вагонов
  def show_railway_carriage_count
    puts "Railway carriage count: #{railway_carriages.size.to_s}"
  end

  # Может принимать маршрут следования
  def set_train_route(train_route)
    if train_route
      @route = train_route
      drive_to(train_route.first_station)
    end
  end

  # Может перемещаться между станциями, указанными в маршруте.
  def drive_to(station)
    dispatcher.train_drive_to(station, self)
    @current_station = station
  end

  # Показывать предыдущую станцию, текущую, следующую, на основе маршрута
  def show_previous_station
    puts "Previous station: #{route.get_previous_station(current_station)}"
  end

  def show_current_station
    puts "Current station: #{current_station}"
  end

  def show_next_station
    puts "Next station: #{route.get_next_station(current_station)}"
  end

  def type
    'Train'
  end

  # для красоты вывода
  def to_s
    "#{type} (#{manufacturer}) № #{number} with #{railway_carriages.size.to_s} railway carriage"
  end

  # >> Управление вагонами

  # интерфейсные методы для прицепки/отцепки вагонов
  def add_railway_carriage(railway_carriage)
    hook_railway_carriage(railway_carriage) if speed == 0
  end

  def remove_railway_carriage(railway_carriage)
    unhook_railway_carriage(railway_carriage) if speed == 0
  end

  # << Управление вагонами

  protected

  attr_reader :railway_carriages # выносим в протектед, т.к. унаследованные классы могут иметь свою логику при смене вагонов

  # виртуальные методы, будут вызываться при соблюдении условий в унаследованных классах
  def hook_railway_carriage(railway_carriage)
    @railway_carriages.push(railway_carriage)
    railway_carriage.check_carriage
  end

  def unhook_railway_carriage(railway_carriage)
    @railway_carriages.delete(railway_carriage)
    railway_carriage.check_carriage
  end

end