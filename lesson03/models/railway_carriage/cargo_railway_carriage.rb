require_relative 'railway_carriage'

class CargoRailwayCarriage < RailwayCarriage
  # Добавить атрибут общего объема (задается при создании вагона)
  attr_reader :total_space
  attr_reader :current_weight

  def initialize(number = 0, total_space = 56_000)
    super number
    @total_space = total_space
    @current_weight = 0
  end

  # Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
  def add_cargo(cargo_weight = 0)
    @current_weight += cargo_weight if current_weight + cargo_weight < total_space
  end

  # Добавить метод, который возвращает занятый объем
  alias busy_space current_weight

  # Добавить метод, который возвращает оставшийся (доступный) объем
  def free_space
    total_space - current_weight
  end

  def check_carriage
    puts 'Cargo is checked chief, we can go!'
  end

  def type
    'Cargo'
  end

  def to_s
    "№ #{number} type: #{type} total #{busy_space}/#{total_space}"
  end
end
