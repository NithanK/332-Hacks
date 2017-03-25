class CarController < ApplicationController
    def index
        @client = Mysql2::Client.new(:host => ENV['IP'], :username => ENV['C9_USER'], :database => "KTCS")
        @car = @client.query("SELECT * FROM car")
    end
end
