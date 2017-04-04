class AdminController < ApplicationController
    def index
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        
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

        #  puts params['make']
        #  puts params['car_VIN']
    end
end
