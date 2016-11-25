puts "Lesson 03 - Train management"

require_relative 'models/train/train_dispatcher'
require_relative 'models/station'
require_relative 'models/train/train_route'
require_relative 'models/train/train'
require_relative 'models/train/passenger_train'
require_relative 'models/train/cargo_train'
require_relative 'models/railway_carriage/railway_carriage'
require_relative 'models/railway_carriage/passenger_railway_carriage'
require_relative 'models/railway_carriage/cargo_railway_carriage'

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
train = PassengerTrain.new(dispatcher: dispatcher, number: '0002233')
train.set_train_route(train_route)
train.manufacturer = 'Telco Ind.'

train2 = CargoTrain.new(dispatcher: dispatcher, number: '0002100')
train2.set_train_route(train_route)
train2.manufacturer = 'Tenemut Inc.'

train3 = PassengerTrain.new(dispatcher: dispatcher, number: '0002400')
train3.set_train_route(train_route)
train3.manufacturer = 'OCP corp.'

train.current_speed
train.accelerate(100)
train.current_speed
train.stop
train.current_speed

train.show_current_station
train.drive_to(second_station)
train.show_previous_station
train.show_current_station
train.show_next_station

dispatcher.show_current_stations_load

dispatcher.show_station_load(second_station)

puts '-----------------------------------------------------------------------'

train.drive_to(last_station)
train2.drive_to(last_station)
train3.drive_to(last_station)

dispatcher.show_current_stations_load
train.show_next_station

last_station.show_trains(show_by_types: true)

wagon = CargoRailwayCarriage.new
train2.add_railway_carriage(wagon)

passenger_wagon = PassengerRailwayCarriage.new
train.add_railway_carriage(passenger_wagon)

last_station.show_trains(show_by_types: true)

#insert demo data

# >> Lesson 05

puts 'Start find train with number 0002233'
puts Train.find('0002233')

puts 'Start find not exists train with number 00033233'
puts Train.find('00033233')

puts PassengerTrain.show_instances_count
puts CargoTrain.show_instances_count

# << Lesson 05

