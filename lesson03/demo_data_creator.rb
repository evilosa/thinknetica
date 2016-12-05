require_relative 'models/train/train_dispatcher'
require_relative 'models/station'
require_relative 'models/train/train_route'
require_relative 'models/train/train'
require_relative 'models/train/passenger_train'
require_relative 'models/train/cargo_train'
require_relative 'models/railway_carriage/railway_carriage'
require_relative 'models/railway_carriage/passenger_railway_carriage'
require_relative 'models/railway_carriage/cargo_railway_carriage'

module Demo
  class << self
    def seed_demo_data
      # Create stations
      first_station = Station.new(name: 'Moscow')
      first_station.description = 'Главная станция РФ'
      first_station.description = 'Наверное крупнейшая станция в РФ'
      first_station.dispatcher_name = 'Гоношилкин Арарат Вадимович'
      first_station.railway_count = 60
      # first_station.dispatcher_name = :gonoshilkin

      second_station = Station.new(name: 'Voronej')
      second_station.description = 'Москва-Воронеж, хрен догонишь'
      second_station.railway_count = 15

      third_station = Station.new(name: 'Rostov')
      third_station.description = 'Большая деревня'
      third_station.railway_count = 30

      fourth_station = Station.new(name: 'Krasnodar')
      fourth_station.description = 'Мухосранск как выражался Маяковский, и к тому же родина'
      fourth_station.railway_count = 10

      last_station = Station.new(name: 'Adler')
      last_station.description = 'Можно купить чурчхеллу на станции круглый год'
      last_station.railway_count = 20

      # Train route
      train_route = TrainRoute.new(first_station, last_station)
      train_route.insert_station(second_station)
      train_route.insert_station(third_station)
      train_route.insert_station(fourth_station)

      # Train
      train = PassengerTrain.new(number: '223-DS')
      train.train_route = train_route
      train.manufacturer = 'Telco Ind.'

      train2 = CargoTrain.new(number: 'MKD05')
      train2.train_route = train_route
      train2.manufacturer = 'Tenemut Inc.'

      train3 = PassengerTrain.new(number: '005-RF')
      train3.train_route = train_route
      train3.manufacturer = 'OCP corp.'

      wagon = CargoRailwayCarriage.new
      train2.add_railway_carriage(wagon)
      wagon.add_cargo 12_430
      wagon2 = CargoRailwayCarriage.new
      wagon2.add_cargo 24_330
      train2.add_railway_carriage(wagon2)

      passenger_wagon = PassengerRailwayCarriage.new
      passenger_wagon.add_passenger
      train.add_railway_carriage(passenger_wagon)
    end
  end
end
