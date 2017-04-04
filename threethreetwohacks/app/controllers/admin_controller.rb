class AdminController < ApplicationController
    def index
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        
        @cars_needing_maintenance = []
        query0 = "select * from car"
        q0 = @client.query(query0)
        q0.each do |car|
            distance_sum = 0
            query1 = "SELECT cars_VIN, date as mostRecentDate FROM maintenance_history where cars_VIN='#{car['VIN']}' order by date DESC limit 1;"
            
            most_recent_date = @client.query(query1)
            if !(most_recent_date.nil?)
                mostRecentDate = most_recent_date.each[0]['mostRecentDate']
                puts mostRecentDate
                query2 = "select * from car_rental_history where date > '#{mostRecentDate}' and car_VIN = #{car['VIN']}"
                q2 = @client.query(query2)
                q2.each do |d|
                    distance_sum += d['distance']
                end
            end
            if distance_sum >= 5000
                @cars_needing_maintenance.push("#{car['make']} #{car['model']}")
            end
        end
        
         
        q = "SELECT car_VIN, SUM(distance)  from car_rental_history GROUP BY car_VIN having  SUM(distance) > 5000"
         
        @getMostRecentMan = @client.query(q)
         
        @getMostRecentMan_arr = []
        @getMostRecentMan.each do |z| 
            @getMostRecentMan_hash = {}
            
            @getMostRecentMan_hash['car_VIN'] = z['car_VIN']
            @getMostRecentMan_arr.push(@getMostRecentMan_hash)
        end

        #############################

        @mostRented = @client.query("SELECT car_VIN from car_rental_history GROUP BY car_VIN ORDER BY COUNT(*) DESC LIMIT 1")
        @leastRented = @client.query("SELECT car_VIN from car_rental_history GROUP BY car_VIN ORDER BY COUNT(*) ASC LIMIT 1")
       
        @mr_arr = []
        @mostRented.each do |x|
            @mr_hash = {}
            @mr_hash['car_VIN'] = x['car_VIN']
            @mr_arr.push(@mr_hash)
        end
        @mostRentedMake = @client.query("SELECT make,model from car where VIN = #{@mr_arr[0]['car_VIN']}")
        @makeArr = []
        
        @mr_arr2 = []
        @leastRented.each do |x|
            @mr_hash = {}
            @mr_hash['car_VIN'] = x['car_VIN']
            @mr_arr2.push(@mr_hash)
        end
        @leastRentedMake = @client.query("SELECT make,model from car where VIN = #{@mr_arr2[0]['car_VIN']}")
        @makeArr2 = []
         
        @mostRentedMake.each do |i|
            @makeHash = {}
            @makeHash['make'] = i['make']
            @makeHash['model'] = i['model']
            @makeArr.push(@makeHash)
        end
        @leastRentedMake.each do |i|
            @makeHash = {}
            @makeHash['make'] = i['make']
            @makeHash['model'] = i['model']
            @makeArr2.push(@makeHash)
        end

    end

end
