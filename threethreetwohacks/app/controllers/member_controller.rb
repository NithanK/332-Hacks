class MemberController < ApplicationController
    require 'mysql2'
    
    def index 
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        #get all members
        query_string = "SELECT * FROM member"
        @member = @client.query(query_string)
        @member_array = []
        @member.each do |member|
            memeber_hash = {}
            memeber_hash['member_number'] = member['member_number']
            memeber_hash['name'] = member['name']
            memeber_hash['address'] = member['address']
            memeber_hash['phone'] = member['phone']
            memeber_hash['email'] = member['email']
            memeber_hash['license_number'] = member['license_number']
            memeber_hash['annual_fee'] = member['annual_fee']
            @member_array.push(memeber_hash)
        end
    end
    
    def profile
        # just go straight to view
        puts 'profile'
    end
    
    def reservations
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        querystring = 'select *, count(access_code) as length_days from (select * from reservation where member_member_number='
        querystring += current_user['member_number']
        querystring += ' order by date asc) as T1 inner join car on T1.car_VIN = car.vin group by access_code order by date'
        @reservation = @client.query(querystring)
        
        # create hash to translate parking lot id to address
        querystring2 = 'select * from parking_location'
        lots = @client.query(querystring2)
        @pl_id_to_address = {}
        lots.each do |lot|
            @pl_id_to_address[lot['pl_id']] = lot['address']
        end
    end
    
    def adminReservations 
         @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        
         # get all the cars, unless they are reserved on that day
        # find the vins to remove...
        @date = Date.today.to_formatted_s(:db) # default to today if date not supplied
         vins_to_remove = @client.query('select car_vin from reservation where date="'+@date+'"')
        vins_to_remove_array = []
        vins_to_remove.each do |vin|
            puts vin
            vins_to_remove_array.push(vin['car_vin'])
        end
        puts '@@@@@'
        puts vins_to_remove_array
        
        puts ('HELELEOEOEOEEOEOEO')
        puts params['location']
        
        # now get all the cars
        @car_array_remove = []
        @car = @client.query("SELECT vin, make, model, year, daily_fee, address FROM car inner join parking_location where car.parking_locations_pl_id=parking_location.pl_id")
        
        puts @car.each
        @car.each do |car|
            puts '%%%%%%%%%%%'
            puts car['address']
            
            if vins_to_remove_array.include? car['vin']
                puts "!!!!!!!!!!!!!"
                car_hash_remove = {}
                car_hash_remove['make'] = car['make']
                car_hash_remove['model'] = car['model']
                car_hash_remove['year'] = car['year']
                car_hash_remove['daily_fee'] = car['daily_fee']
                car_hash_remove['address'] = car['address']
                car_hash_remove['vin'] = car['vin']
                @car_array_remove.push(car_hash_remove)
            end
        end
        
        puts '**************************'
        puts @car_array_remove
            
        @length_options = [ [1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7] ]
        
    end 
    
            
        
end
