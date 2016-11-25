require_relative 'railway_carriage'

class PassengerRailwayCarriage < RailwayCarriage

  def check_carriage
    puts 'All people on board, captain, we can go!'
  end

  def type
    'Passengers'
  end

end