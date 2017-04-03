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
    
    def adminReservationDatepicker 
         @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        
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
        @resDate = params['day']
        
        # now get all the cars
        @car_array_remove = []
        @car = @client.query("SELECT * from reservation inner join car on reservation.car_VIN = car.VIN;")
        
        puts @car.each
        @car.each do |car|
            puts '%%%%%%%%%%%'
            puts car['date']
            puts car['car_VIN']
            puts params['day'].to_s==car['date'].to_s
            puts params['day']
            puts car['date']
            puts 'TTTTTTTTTTTTTTTT'
            puts (@car_array_remove.any?{|h| h[:a] == car['car_VIN']})
            
            puts 'TTTTTTTTTTTTTTTT'
            if (vins_to_remove_array.include? car['car_VIN'] and params['day'].to_s == car['date'].to_s )
                puts "!!!!!!!!!!!!!"
                puts car['date']
                car_hash_remove = {}
                car_hash_remove['make'] = car['make']
                car_hash_remove['model'] = car['model']
                car_hash_remove['year'] = car['year']
                car_hash_remove['car_VIN'] = car['car_VIN']
                @car_array_remove.push(car_hash_remove)
            end
        end
        
        puts '**************************'
        puts @car_array_remove
            
        @length_options = [ [1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7] ]
        
    end
        
        
    def invoice
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        member_number = params['id']
        @current_member = @client.query("select name,email from member where member_number=#{member_number}").each[0]
        start_of_this_month = Date.today.beginning_of_month
        querystring = "select * from car_rental_history  inner join car on car.VIN=car_rental_history.car_VIN"
        querystring += " inner join member on member.member_number=car_rental_history.member_member_number"
        querystring += " where do_time >= '#{start_of_this_month}' and member_member_number = '#{member_number}' order by do_time asc"
        @usage = @client.query(querystring)
        @invoice_lines = [];
        @invoice_total = 0;
        @usage.each do |line|
            unless (line['pu_time']==nil or line['do_time']==nil)
                line_hash = {}
                days_used = Date.parse(line['do_time'].to_s)-Date.parse(line['pu_time'].to_s)
                line_hash['days_used'] = days_used.to_i+1
                line_hash['daily_fee'] = line['daily_fee']
                line_hash['pickup'] = Date.parse(line['pu_time'].to_s)
                line_hash['dropoff'] = Date.parse(line['do_time'].to_s)
                line_hash['car'] = "#{line['make']} #{line['model']} (#{line['year']})"
                @invoice_lines.push(line_hash)
                @invoice_total += line_hash['daily_fee'] * line_hash['days_used']
            end
        end
    end
end
