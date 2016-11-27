class TrainDispatcher

  @default

  # Синглтон диспетчера поездов
  def self.default
    @default ||= TrainDispatcher.new
  end

    attr_reader :station_trains
    
    def initialize()
       @station_trains = Hash.new { |hash, key| hash[key] = [] }
    end

    # Методы для вызова из станций
    def register_station(station)
        station_trains[station] = [] if station
    end
    
    def train_arrival(station, train)
        station_trains[station].push(train)
    end
    
    def train_departure(station, train)
        station_trains[station].delete(train)
    end

    # Методы для вызова из поезда
    def get_train_current_station(train)
        station_trains.each do |key, value|
            if value.include?(train)
                return key
            end
        end
    end

    def train_drive_to(new_station, train)
        # удалем поезд с текущей станции
        station_trains.each do |key, value|
            if value.include?(train)
                value.delete(train)
                break # мы нашли поезд, дальше можно не обходить
            end
        end

        # регистрируем на новой станции
        train_arrival(new_station, train)
    end

    def show_stations
      station_trains.each_key { |key| puts key}
    end

    def show_current_stations_load
       station_trains.each_key { |key| show_station_load(key)}
    end

    def show_current_stations_load_by_type
      station_trains.each_key { |key| show_station_load_by_type(key) }
    end

    def show_station_load(station)
        puts '------------------------'
        puts "Station: #{station}, trains:"
        station_trains[station].each { |train| puts "   #{train}" } if station_trains[station]
    end

    def show_station_load_by_type(station)
        puts '------------------------'
        result = { }
        station_trains[station].each do |train|
            if result[train.type].nil?
                # новый тип поезда, добавляем в хеш
                result[train.type] = { :count => 1, :trains => [train]}
            else
                result[train.type][:count] += 1
                result[train.type][:trains].push(train)
            end
        end

        puts "Station #{station} contain next trains:"
        result.each_key do |key|
            puts "  - type: #{key} - #{result[key][:count]}"
            result[key][:trains].each { |train| puts "      - #{train}"}
        end
    end
end