class AdminController < ApplicationController
    def index
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        @mostRented = @client.query("SELECT car_VIN from car_rental_history GROUP BY car_VIN ORDER BY COUNT(*) DESC LIMIT 1")
        @mr_arr = []
         @mostRented.each do |x|
             @mr_hash = {}
             @mr_hash['car_VIN'] = x['car_VIN']
             @mr_arr.push(@mr_hash)
         end
          @mostRentedMake = @client.query("SELECT make,model from car where VIN = #{@mr_arr[0]['car_VIN']}")
         @makeArr = []
         @mostRentedMake.each do |i|
             @makeHash = {}
             @makeHash['make'] = i['make']
             @makeHash['model'] = i['model']
             @makeArr.push(@makeHash)
         end
         puts params['make']
         puts params['car_VIN']
         
         
         
         
         
         
         q = "SELECT car_VIN, SUM(distance)  from car_rental_history GROUP BY car_VIN having  SUM(distance) > 5000"
         
        @getMostRecentMan = @client.query(q)
         
         @getMostRecentMan_arr = []
         @getMostRecentMan.each do |z| 
             @getMostRecentMan_hash = {}
             
             @getMostRecentMan_hash['car_VIN'] = z['car_VIN']
             @getMostRecentMan_arr.push(@getMostRecentMan_hash)
            
             

         end 
          
             
    
         
    end
    
    
        
        
        
        
    
    
    
    
    
    
end
