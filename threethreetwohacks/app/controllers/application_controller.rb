class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  ENV['TZ'] = 'EST' # set the timezone
  ENV['ROOT_PATH'] = 'https://threethreetwohacks-noamhacker.c9users.io'
  include SessionsHelper
end
