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
        querystring += ' order by date asc) as T1 group by access_code'
        @reservation = @client.query(querystring)
    end
            
        
end
