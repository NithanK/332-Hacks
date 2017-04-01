class CarController < ApplicationController
    def index
        if !logged_in?
            redirect_to '/login'
        end
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        @car = @client.query("SELECT make, model, year, daily_fee, address FROM car inner join parking_location where car.parking_locations_pl_id=parking_location.pl_id")
        lots = @client.query("select * from parking_location;")
        @address_to_id = []
        lots.each do |pl|
            @address_to_id.push([pl['address'], pl['pl_id']])
        end
    end
    
    def create
       vin = params['vin']
       parking_locations_pl_id = params['parking_locations_pl_id']
       make = params['make']
       model = params['model']
       year = params['year']
       daily_fee = params['daily_fee']
       license_plate = params['license_plate']
       colour = params['colour']
       @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
       querystring = 'insert into car (VIN, parking_locations_pl_id, make, model, year, daily_fee, license_plate, colour) values '
       querystring += '("' + vin + '", "' + parking_locations_pl_id + '", "' + make + '", "' + model + '", "' + year + '", "'
       querystring += daily_fee + '", "' + license_plate + '", "' + colour + '")'
       # do the insert query
       @client.query(querystring)
       redirect_to '/cars/view'
    end
    
    def availability
        
        # NOTE: TAKE INTO ACCOUNT THE LENGTH OF THE RESERVATION (this is currently day-by-day but some reservations last 5 days)
        
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        
         # get all the cars, unless they are reserved on that day
        # find the vins to remove...
        @date = params['date'] || Date.today.to_formatted_s(:db) # default to today if date not supplied
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
                car_hash['vin'] = car['vin']
                @car_array.push(car_hash)
            end
        end
        
        @length_options = [ [1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7] ]
       
        # puts vins_to_remove_array
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
    
    def reserve
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        length_days = params['length_days'].to_i
        start_date = Date.parse(params['date'])
        start_date -= 1
        car_VIN = params['car_VIN'].to_s
        member_member_number = params['member_member_number'].to_s
        access_code = params['access_code']
        # make one reservation per day based on the length of days the user specified
        (1..length_days).each do |i|
            res_number = rand(9**9).to_s
            res_date = start_date + i
            querystring = 'insert into reservation (res_number, car_VIN, member_member_number, date, access_code,length_days) values('
            querystring += '"' + res_number + '", "' + car_VIN + '", "' + member_member_number + '", "' + res_date.to_s + '", "' + access_code + '", 1)'
            @client.query(querystring)
        end
        
        # redirect to car show page
        redirect_to "/cars/view/#{car_VIN}"
    end
    
    def unlock

        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        access_code = params['access_code']
        unlocked = params['unlocked']
        vin = params['car_VIN']
        date = params['date']
        member_member_number = current_user['member_number']
        pu_reading = params['pu_reading']
        do_reading = pu_reading # temporarily identical in 'not_yet_returned' status
        status_on_return = 'not_yet_returned'
        distance = 0
        pu_time = DateTime.now
        status_on_pickup = params['status_on_pickup']
        
        unless unlocked == 'yes'
            # set reservation as unlocked
            querystring = "update reservation set unlocked='yes' where access_code='#{access_code}'"
            @client.query(querystring)
            querystring2 = "insert into car_rental_history (car_VIN, date, member_member_number, pu_reading, "
            querystring2 += "do_reading, status_on_return, distance, pu_time, status_on_pickup)"
           
            # add to car rental history with status of 'not_yet_returned'
            querystring2 += " values ('#{vin}', '#{date}', '#{member_member_number}', #{pu_reading}, #{do_reading},"
            querystring2 += " '#{status_on_return}', #{distance}, '#{pu_time}', '#{status_on_pickup}')"
            @client.query(querystring2)
        end
        
        # redirect to car show page
        redirect_to "/cars/view/#{vin}"
    end
    
    def return_car
        
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        
        # get the car info
        vin = params['car_VIN']
        date = params['date']
        member_member_number = current_user['member_number']
        do_reading = params['do_reading']
        distance = 0
        do_time = DateTime.now
        status_on_return = params['status_on_return']
        access_code = params['access_code']
        
        # calculate the distance. first get the pickup reading
        querystring = "select pu_reading from car_rental_history where car_VIN='#{vin}' and date='#{date}' and member_member_number='#{member_member_number}'"
        po_reading = @client.query(querystring).each[0]['pu_reading']
        distance = do_reading.to_f-po_reading.to_f
        
        # update car's rental history with dropoff reading, time and status
        querystring2 = "update car_rental_history set do_reading='#{do_reading}', do_time='#{do_time}', status_on_return='#{status_on_return}', distance='#{distance}'"
        querystring2 += " where car_VIN='#{vin}' and date='#{date}' and member_member_number='#{member_member_number}'"
        @client.query(querystring2)
        
        # remove record from reservations table
        querystring3 = "delete from reservation where access_code='#{access_code}'"
        @client.query(querystring3)
        
        # redirect to car show page
        redirect_to "/cars/view/#{vin}"

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
        
       
        
        if @commentHistory[0].has_value?(params['vin']) && @commentHistory[0].has_value?(session[:member_number])
            client.query("update rental_comment set rating = #{params['rating']},comment='#{params["newComment"]}' where member_member_number = #{session[:member_number]};")
        else
            client.query("INSERT INTO rental_comment(car_VIN,member_member_number,rating,comment) VALUES (#{params['vin']},#{session[:member_number]},#{params['rating']},'#{params["newComment"]}');")
        end
    end  
    
    
    
    def createReply
        vin = params['car_VIN']
        client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        newRep = "SELECT * from rental_comment" #hardcoded b/c broken
        getMem = "SELECT member_member_number FROM rental_comment WHERE car_VIN = 1030"
        @reply = client.query(newRep)
        @reply_array = []
        @reply.each do |reply|
            reply_hash = {}
            reply_hash["comment_reply"] = reply["comment_reply"]
            reply_hash['car_VIN'] = reply['car_VIN']
            reply_hash['member_member_number'] = reply['member_member_number']
            
            @reply_array.push(reply_hash)
        end
        puts @reply
        #insertion = "INSERT INTO rental_comment(car_VIN,member_member_number,rating,comment,comment_reply) VALUES ('1030','50000','','', '" + params['comment_reply'] + "')"
        #insertion = "UPDATE rental_comment SET comment_reply ="'+ params['comment_reply']' + "WHERE car_VIN ="' +params['car_VIN']+ '" + 
     #client.query(insertion)
    
    


    end


    
        
        
    
end
