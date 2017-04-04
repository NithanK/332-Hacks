class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require 'active_support'
  ENV['TZ'] = 'EST' # set the timezone
  ENV['ROOT_PATH'] = 'https://threethreetwohacks-tjatjenahej.c9users.io'
  include SessionsHelper
end
