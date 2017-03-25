class CarController < ApplicationController
    def index
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        @car = @client.query("SELECT make, model, year, daily_fee, address FROM car inner join parking_location where car.parking_locations_pl_id=parking_location.pl_id")
        # @car_array = []
        # @car.each do |car|
        #     car_hash = {}
        #     car_hash['make'] = car['make']
        #     car_hash['model'] = car['model']
        #     car_hash['year'] = car['year']
        #     car_hash['daily_fee'] = car['daily_fee']
        #     car_hash['address'] = car['address']
        #     @car_array.push(car_hash)
        # end
        # puts @client.query('select address from car inner join parking_location where car.parking_locations_pl_id=parking_location.pl_id and vin=1000;').first['address']
    end
end
