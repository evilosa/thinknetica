require_relative 'train'
require_relative '../railway_carriage/cargo_railway_carriage'

class CargoTrain < Train

  # >> Validation rules
  NUMBER_FORMAT = /^\w\w\w-?\w\w\z/
  add_value_type_validation_rule(:dispatcher, TrainDispatcher)
  add_value_format_validation_rule(:number, NUMBER_FORMAT)
  # << Validation rules

  def type
    'Cargo train'
  end

  protected

  def hook_railway_carriage(railway_carriage)
    if railway_carriage.instance_of? CargoRailwayCarriage
      super
      # К примеру проверим тормоза при подсоединении вагона
      check_brake
    end
  end

  def unhook_railway_carriage(railway_carriage)
    if railway_carriage.instance_of? CargoRailwayCarriage
      super
      check_brake
    end
  end

  def check_brake
    puts 'Brake on cargo train is good chief!'
  end

end