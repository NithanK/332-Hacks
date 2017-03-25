class CarController < ApplicationController
    def index
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        @car = @client.query("SELECT * FROM car")
        @car_array = []
        @car.each do |car|
            car_hash = {}
            car_hash['make'] = car['make']
            car_hash['model'] = car['model']
            @car_array.push(car_hash)
        end
    end
end
