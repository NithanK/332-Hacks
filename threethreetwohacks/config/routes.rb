Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/parking_locations', to: 'parking_locations#index'

  get '/cars/view', to: 'car#index'

end
