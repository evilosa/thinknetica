require_relative 'railway_carriage'

class PassengerRailwayCarriage < RailwayCarriage
  # Добавить атрибут общего кол-ва мест (задается при создании вагона)
  attr_reader :passengers_places
  attr_reader :total_passengers

  def initialize(number = 0, passengers_places = 100)
    super number

    @passengers_places = passengers_places
    @total_passengers = 0
  end

  # Добавить метод, который "занимает места" в вагоне (по одному за раз)
  def add_passenger
    @total_passengers += 1 if total_passengers < passengers_places
  end

  # Добавить метод, возвращающий кол-во свободных мест в вагоне.
  def free_places
    passengers_places - total_passengers
  end

  # Добавить метод, который возвращает кол-во занятых мест в вагоне
  alias busy_places total_passengers

  def check_carriage
    puts 'All people on board, captain, we can go!'
  end

  def type
    'Passengers'
  end

  def to_s
    "№ #{number} type: #{type} total #{busy_places}/#{passengers_places}"
  end
end
