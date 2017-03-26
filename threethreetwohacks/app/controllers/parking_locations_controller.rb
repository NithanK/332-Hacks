class ParkingLocationsController < ApplicationController
    
    def index
        client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        @location = client.query("SELECT * FROM parking_location")
       
    end 
end
