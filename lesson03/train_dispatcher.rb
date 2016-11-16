class TrainDispatcher
    
    attr_reader :station_trains
    
    def initialize()
       @station_trains = {}
    end
    
    def register_station(station)
        station_trains[:station => station, :trains => []]
    end
    
    def train_arrival(station, train)
        station_trains[station].push(train)
    end
    
    def train_departure(station, train)
        station_trains[station].delete(train) if station_trains[station].include?(train)
    end
    
    def train_drive_to(station)
        
    end
    
    def show_current_stations_load
       station_trains.each do |station|
           puts station
       end
    end
end