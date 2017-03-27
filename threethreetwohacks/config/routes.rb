Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/parking_locations', to: 'parking_locations#index'

  get '/cars/view', to: 'car#index'
 
  
  get'/member/:id/rental_history', to: 'member_rental_history#index'


  get '/cars/view/comment/:vin', to: 'car#show'


  get'/cars/car_rental_history/:vin', to: 'car_rental_history#index' 
  get '/cars/rent/:date', to: 'car#availability'
  
  post '/cars/create', to: 'car#create'
  
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get   '/logout',  to: 'sessions#destroy'

end
