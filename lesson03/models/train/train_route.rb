class TrainRoute
  attr_reader :stations_list

  def initialize(first_station, last_station)
    @stations_list = [first_station, last_station]
  end

  def first_station
    stations_list.first
  end

  def last_station
    stations_list.last
  end

  def get_previous_station(station)
    if stations_list.include?(station) && station != first_station
      station_index = stations_list.find_index(station)
      stations_list[station_index - 1]
    else
      first_station
    end
  end

  def get_next_station(station)
    if stations_list.include?(station) && station != last_station
      stations_list[stations_list.find_index(station).next]
    else
      last_station
    end
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
    "Route from: '#{first_station}' to '#{last_station}'"
  end
end
