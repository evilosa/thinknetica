puts "Lesson 03 - Train management"

load('./station.rb')
load('./train_route.rb')
load('./train.rb')

#create classes

# Stations
firstStation = Station.new("Moscow")
secondStation = Station.new("Voronej")
thirdStation = Station.new("Rostov")
fourthStation = Station.new("Krasnodar")
lastStation = Station.new("Adler")

# Train route
train_route = TrainRoute.new(firstStation, lastStation)
train_route.insert_station(secondStation)
train_route.insert_station(thirdStation)
train_route.insert_station(fourthStation)

# Train
train = Train.new('0002233', false, 10)
train.set_train_route(train_route)

train.current_speed
train.accelerate(100)
train.current_speed
train.stop
train.current_speed

train.current_station
train.drive_to(secondStation)
train.show_previous_station
train.show_next_station

#insert demo data



