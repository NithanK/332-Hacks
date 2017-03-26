class CarController < ApplicationController
    require 'mysql2'
    def index
        client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        @car = client.query("SELECT * FROM car")
        
    end
    
    def show
        vin = params['vin']
        client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        @comment = client.query("select * from rental_comment inner join car ON rental_comment.car_VIN = car.vin inner join member ON rental_comment.member_member_number = member.member_number where VIN ="+vin)
        
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
end
