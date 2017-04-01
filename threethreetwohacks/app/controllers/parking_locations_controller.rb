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
end
