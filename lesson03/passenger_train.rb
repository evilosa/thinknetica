require_relative('train')

class PassengerTrain < Train

  def type
    'Passenger train'
  end

  protected

  def hook_railway_carriage(railway_carriage)
    if railway_carriage.instance_of? PassengerRailwayCarriage
      super
      passenger_train_generic_check_logic
    end
  end

  def unhook_railway_carriage(railway_carriage)
    if railway_carriage.instance_of? PassengerRailwayCarriage
      super
      passenger_train_generic_check_logic
    end
  end

  def passenger_train_generic_check_logic
    puts 'Passangers railway carriage added to passenger train successfuly'
  end

end