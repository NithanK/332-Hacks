class ParkingLocationsController < ApplicationController
    
    def index
        client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        @location = client.query("SELECT * FROM parking_location")
       
    end 

    def create
        address = params['address']
        pl_id = params['pl_id']
        num_spaces = params['num_spaces']
        client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        client.query("insert into parking_location (pl_id, address, num_spaces) values ('#{pl_id}','#{address}','#{num_spaces}')")
        redirect_to '/parking_locations'
    end

    
    def availability
        
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        
         # get all the cars, unless they are reserved on that day
        # find the vins to remove...
        @date = Date.today.to_formatted_s(:db) # default to today if date not supplied
         vins_to_remove = @client.query('select car_vin from reservation where date="'+@date+'"')
        vins_to_remove_array = []
        vins_to_remove.each do |vin|
            vins_to_remove_array.push(vin['car_vin'])
        end
        
        puts ('HELELEOEOEOEEOEOEO')
        puts params['location']
        
        # now get all the cars
        @car_array_remove = []
        @car = @client.query("SELECT vin, make, model, year, daily_fee, address FROM car inner join parking_location where car.parking_locations_pl_id=parking_location.pl_id")
        @car_array = []
        puts @car.each
        @car.each do |car|
 
            
            if vins_to_remove_array.include? car['vin'] && params['location'] == car['address']
                car_hash_remove = {}
                car_hash_remove['make'] = car['make']
                car_hash_remove['model'] = car['model']
                car_hash_remove['year'] = car['year']
                car_hash_remove['daily_fee'] = car['daily_fee']
                car_hash_remove['address'] = car['address']
                car_hash_remove['vin'] = car['vin']
                @car_array_remove.push(car_hash_remove)
            elsif params['location'] == car['address']
                car_hash = {}
                car_hash['make'] = car['make']
                car_hash['model'] = car['model']
                car_hash['year'] = car['year']
                car_hash['daily_fee'] = car['daily_fee']
                car_hash['address'] = car['address']
                car_hash['vin'] = car['vin']
                @car_array.push(car_hash)
            end
        end
        puts '**************************'
        puts @car_array
        puts @car_array_remove
            
        @length_options = [ [1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7] ]
        
    end 

end
