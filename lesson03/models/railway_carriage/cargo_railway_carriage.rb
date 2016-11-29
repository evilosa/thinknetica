require_relative 'railway_carriage'

class CargoRailwayCarriage < RailwayCarriage
  def check_carriage
    puts 'Cargo is checked chief, we can go!'
  end

  def type
    'Cargo'
  end
end
