require_relative '../../modules/manufacturer'

class RailwayCarriage
  include Manufacturer

  def check_carriage
    puts 'Default check completed successfuly!'
  end

  def type
    'Railway carriage'
  end
end
