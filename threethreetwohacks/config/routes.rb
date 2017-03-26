Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/cars/view', to: 'car#index'
  get'cars/car_rental_history', to: 'car_rental_history#index' 
end
