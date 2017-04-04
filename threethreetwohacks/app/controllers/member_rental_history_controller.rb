class MemberRentalHistoryController < ApplicationController
    require 'mysql2'
    def index
        id = params["id"]
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
      #  query_string = "SELECT * FROM car_rental_history INNER JOIN member on car_rental_history.member_member_number = member.member_number WHERE member_number="+id
        car_query ="SELECT * FROM (SELECT * FROM car_rental_history INNER JOIN member on car_rental_history.member_member_number = member.member_number) as t1 INNER JOIN car on t1.car_VIN = car.VIN WHERE member_number="+id
        @memberRentHist = @client.query(car_query)
        @memberRentHist_array = []
        @memberRentHist.each do |memberRentHist|
            memberRentHist_hash = {}
            memberRentHist_hash['date'] = memberRentHist['date']
            memberRentHist_hash['make'] = memberRentHist['make']
            memberRentHist_hash['model'] = memberRentHist['model']
            unless (memberRentHist['pu_time']==nil or memberRentHist['do_time']==nil)
                length_days = (Date.parse(memberRentHist['do_time'].to_s)-Date.parse(memberRentHist['pu_time'].to_s)).to_i+1
                memberRentHist_hash['length_days'] = length_days;
            end
            @memberRentHist_array.push(memberRentHist_hash)
     end   
    end
end
