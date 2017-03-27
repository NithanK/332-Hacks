class SessionsController < ApplicationController
    def new
        
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
                redirect_to '/cars/view'
            end
        end
    end
    
    def destroy
        log_out
        redirect_to '/login'
    end
end
