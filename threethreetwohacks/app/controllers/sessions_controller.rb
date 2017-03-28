class SessionsController < ApplicationController
    def new
        # just goes straight to the view
    end
    
    def create
        email = params['email']
        # password = params['password']
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        # find member by email
        if email == ""
            redirect_to '/login?error_message=Email%20cannot%20be%20blank!'
        else
            member = @client.query('select * from member where email="'+email+'"')
            # check if member exists
            if member.each[0].nil? # does not exist
                @error_message = "Member not found!"
                redirect_to '/login?error_message=Member%20not%20found!'
            else # does exist
                member_number = member.first['member_number']
                # set cookie (from sessions helper)
                login member_number
                redirect_to '/'
            end
        end
    end
    
    def signup
        member_number = params['member_number']
        name = params['name']
        address = params['address']
        phone = params['phone']
        email = params['email']
        license_number = params['license_number']
        annual_fee = params['annual_fee']
        
        # create user
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        querystring = 'insert into member (member_number, name, address, phone, email, license_number, annual_fee) values ("'
        querystring += member_number + '", "'
        querystring += name + '", "'
        querystring += address + '", "'
        querystring += phone + '", "'
        querystring += email + '", "'
        querystring += license_number + '", "'
        querystring += annual_fee + '")'
        puts querystring
        @client.query(querystring)
        login member_number
        redirect_to '/'
    end
    
    def destroy
        log_out
        redirect_to '/login'
    end
end
