load('./train_dispatcher.rb')

class Train

  attr_accessor :speed

  attr_reader :number, :type, :railway_carriage_count, :route, :dispatcher

  def initialize(dispatcher: TrainDispatcher.new, number: '0001', type: 'passangers', railway_carriage_count: 10)
    @dispatcher = dispatcher
    @speed = 0
    @number = number
    @type = type
    @railway_carriage_count = railway_carriage_count
  end

  # Может набирать скорость
  def accelerate(speed)
    self.speed += speed
  end

  # Может показывать текущую скорость
  def current_speed
    puts "Current speed: #{speed} km/h"
  end

  # Может тормозить (сбрасывать скорость до нуля)
  def stop
    self.speed = 0
  end

  # Может показывать количество вагонов
  def show_railway_carriage_count
    puts "Railway carriage count: #{railway_carriage_count}"
  end

  # Может прицеплять/отцеплять вагоны
  def hook_railway_carriage
    @railway_carriage_count += 1 if speed == 0
  end

  def unhook_railway_carriage
    @railway_carriage_count -= 1 if speed == 0 && railway_carriage_count > 0
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
  end

  # Показывать предыдущую станцию, текущую, следующую, на основе маршрута
  def show_previous_station
    puts "Previous station: #{route.get_previous_station(current_station)}"
  end

  def current_station
    return dispatcher.get_train_current_station(self)
  end

  def show_current_station
    puts "Current station: #{current_station}"
  end

  def show_next_station
    puts "Next station: #{route.get_next_station(current_station)}"
  end

  # для красоты вывода
  def to_s
    "Train № #{number} with #{railway_carriage_count} type #{type} railway carriage"
  end

end