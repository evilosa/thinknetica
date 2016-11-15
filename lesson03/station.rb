class Station

  attr_reader :name
  attr_reader :train_list

  def initialize(name)
    @name = name
    @train_list = []
  end

  def train_arrival(train)
    @train_list.push(train)
  end

  def train_departure(train)
    @train_list.delete(train) if @train_list.include?(train)
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