require_relative 'train/train_dispatcher'
require_relative '../modules/instance_counter'
require_relative '../modules/validation'

class Station
  include InstanceCounter
  include Validation

  # >> Validation rules
  validate :name, :availability
  # << Validation rules

  @@stations = []

  def self.all
    @@stations
  end

  attr_reader :name, :dispatcher

  def initialize(name: '')
    @name = name
    @dispatcher = TrainDispatcher.instance
    dispatcher.register_station(self)

    @@stations << self
    validate!
  end

  # написать метод, который принимает блок и 
  # проходит по всем поездам на станции, передавая каждый поезд в блок.
  def each_train
    dispatcher.get_station_trains(self).each { |train| yield train }
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
