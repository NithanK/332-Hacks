module SessionsHelper
    
    def login(member_number)
        session[:member_number] = member_number
    end
    
    def current_user
        member_number = session[:member_number]
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        # find member by member_number
        if member_number.nil?
            member_number=""
        end
        member = @client.query('select * from member where member_number="'+member_number+'"')
        return member.each[0]
    end
    
    def logged_in?
        !current_user.nil?
    end
    
    def log_out
        session.delete(:member_number)
        @current_user = nil
    end
    
    def isAdmin?
        current_user['email'] == "admin@queensu.ca"
    end
    
end
