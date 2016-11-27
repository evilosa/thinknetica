require_relative 'train/train_dispatcher'
require_relative '../modules/instance_counter'
require_relative '../modules/validation'

class Station
  include InstanceCounter
  include Validation

  # >> Validation rules
  add_value_availability_validation_rule(:name)
  add_value_type_validation_rule(:dispatcher, TrainDispatcher)
  # << Validation rules

  @@stations = []

  def self.all
    @@stations
  end

  attr_reader :name, :dispatcher

  def initialize(name: '', dispatcher: TrainDispatcher.default)
    @name = name
    @dispatcher = dispatcher
    dispatcher.register_station(self)

    @@stations << self
    validate!
  end

  def train_arrival(train)
    dispatcher.train_arrival(self, train)
  end

  def train_departure(train)
    dispatcher.train_departure(self, train)
  end

  def show_trains(show_by_types: false)

    if show_by_types
      dispatcher.show_station_load_by_type(self)
    else
      dispatcher.show_station_load(self)
    end
  end

  def to_s
    name
  end

end