class TrainRoute
  attr_reader :stations_list

  def initialize(firstStation, lastStation)
    @stations_list = [firstStation, lastStation]
  end

  def first_station
    stations_list.first
  end

  def last_station
    stations_list.last
  end

  def get_previous_station(station)
    station_index = stations_list.find_index(station)
    stations_list[station_index - 1] if station_index > 0 && station_index <= (stations_list.size - 1)
  end

  def get_next_station(station)
    stations_list[stations_list.find_index(station).next] if stations_list.include?(station) && station != last_station
  end

  def show_station_list
    stations_list.each { |station| puts station }
  end

  # Может добавлять промежуточную станцию в список
  def insert_station(station)
    stations_list.insert(-2, station)
  end

  # Может удалять промежуточную станцию из списка
  def remove_station(station)
    stations_list.delete(station)
  end

  def to_s
    puts "Route from: '#{first_station}' to '#{last_station}'"
  end

end