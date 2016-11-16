puts "Lesson 03 - Train management"

load('./train_dispatcher.rb')
load('./station.rb')
load('./train_route.rb')
load('./train.rb')

#create classes

# dispatcher
dispatcher = TrainDispatcher.new

# Stations
first_station = Station.new(name: "Moscow", dispatcher: dispatcher)
second_station = Station.new(name: "Voronej", dispatcher: dispatcher)
third_station = Station.new(name: "Rostov", dispatcher: dispatcher)
fourth_station = Station.new(name: "Krasnodar", dispatcher: dispatcher)
last_station = Station.new(name: "Adler", dispatcher: dispatcher)

# Train route
train_route = TrainRoute.new(first_station, last_station)
train_route.insert_station(second_station)
train_route.insert_station(third_station)
train_route.insert_station(fourth_station)

# Train
train = Train.new(dispatcher: dispatcher, train_number: '0002233', train_passangers: false, railway_carriage_count: 10)
train.set_train_route(train_route)

train.current_speed
train.accelerate(100)
train.current_speed
train.stop
train.current_speed

train.current_station
train.drive_to(second_station)
train.show_previous_station
train.show_next_station

dispatcher.show_current_stations_load

#insert demo data



