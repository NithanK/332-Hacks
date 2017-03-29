class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  ENV['TZ'] = 'EST' # set the timezone
  include SessionsHelper
end
