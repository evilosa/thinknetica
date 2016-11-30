require_relative '../../modules/manufacturer'
require_relative '../../modules/number_searchable'

class RailwayCarriage
  include Manufacturer
  include NumberSearchable

  def initialize(number = 0)
    @number = number.to_s
  end

  def check_carriage
    puts 'Default check completed successfuly!'
  end

  def type
    'Railway carriage'
  end

  def to_s
    "№ #{number} #{type}"
  end
end
