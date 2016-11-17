load('./train_dispatcher.rb')

class Station

  attr_reader :name, :dispatcher

  def initialize(name: '', dispatcher: TrainDispatcher.new)
    @name = name
    @dispatcher = dispatcher
    dispatcher.register_station(self)
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