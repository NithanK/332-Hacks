class CarRentalHistoryController < ApplicationController
    require 'mysql2'
    def index
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        @carHistory =  @client.query("SELECT * FROM car INNER JOIN car_rental_history on car.VIN = car_rental_history.car_VIN")
        @carHistory_array = []
        @carHistory.each do |carHistory|
            carHistory_hash = {}
            carHistory_hash['make'] = carHistory['make']
            carHistory_hash['model'] = carHistory['model']
            carHistory_hash['status_on_return'] = carHistory['status_on_return']
             carHistory_hash['distance'] = carHistory['distance']
            @carHistory_array.push(carHistory_hash)
        end
        puts @carHistory_array
    end
end
