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
    
    def create
        puts params['make']
    end
    
    def availability
        
        # NOTE: TAKE INTO ACCOUNT THE LENGTH OF THE RESERVATION (this is currently day-by-day but some reservations last 5 days)
        
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        
         # get all the cars, unless they are reserved on that day
        # find the vins to remove...
        @date = params['date']
        vins_to_remove = @client.query('select car_vin from reservation where date="'+@date+'"')
        vins_to_remove_array = []
        vins_to_remove.each do |vin|
            vins_to_remove_array.push(vin['car_vin'])
        end
        
        # now get all the cars
        @car = @client.query("SELECT vin, make, model, year, daily_fee, address FROM car inner join parking_location where car.parking_locations_pl_id=parking_location.pl_id")
        @car_array = []
        @car.each do |car|
            unless vins_to_remove_array.include? car['vin']
                car_hash = {}
                car_hash['make'] = car['make']
                car_hash['model'] = car['model']
                car_hash['year'] = car['year']
                car_hash['daily_fee'] = car['daily_fee']
                car_hash['address'] = car['address']
                @car_array.push(car_hash)
            end
        end
        
       
        puts vins_to_remove_array

    end
    
    def show
        @vin = params['vin']
        client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        @comment = client.query("select * from rental_comment inner join car ON rental_comment.car_VIN = car.vin inner join member ON rental_comment.member_member_number = member.member_number where VIN ="+@vin)
        
        @commentHistory = []
        @comment.each do |x|
            commentHistory_hash = {}
            commentHistory_hash['name'] = x['name']
            commentHistory_hash['comment'] = x['comment']
            commentHistory_hash['rating'] = x['rating']
            commentHistory_hash['make'] = x['make']
            commentHistory_hash['model'] = x['model']
            commentHistory_hash['year'] = x['year']
            @commentHistory.push(commentHistory_hash)
        end 
    end 
    
    def createComment
        client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        
        @comment = client.query("select * from rental_comment")
        @commentHistory = []
        
        @comment.each do |x|
            commentHistory_hash = {}
            commentHistory_hash['car_VIN'] = x['car_VIN']
            commentHistory_hash['member_member_number'] = x['member_member_number']
            @commentHistory.push(commentHistory_hash)
        end
        
        puts params['newComment']
        puts params['vin']
        puts params['rating']
        
        if @commentHistory[0].has_value?(params['vin'] && '50010')
            puts 'works'
        else
            client.query("INSERT INTO rental_comment(car_VIN,member_member_number,rating,comment) VALUES ("+ params['vin'] + ", 50010 ," + params['rating'] +","+ params['newComment'] +");")
        end
        
        
        
    end 
end
