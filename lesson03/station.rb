load('./train_dispatcher.rb')

class Station

  attr_reader :name
  attr_reader :train_list, :dispatcher

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

  def show_trains(show_by_types = false)

    if show_by_types
      passangers, cargos = 0

      train_list.each { |train| train.train_passangers ? passangers += 1 : cargos += 1 }
      puts "Station have #{passangers} passangers train, and #{cargos} cargos train"
    else
      puts "Station #{name}, trains list:"
      train_list.each { |train| puts train }
    end
  end

  def to_s
    puts "Station #{name}"
  end

end