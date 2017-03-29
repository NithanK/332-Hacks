Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # homepage:
  root 'car#availability'
  # SET THE TIMEZONE IN THE CLI
  # TZ=EST ruby -e 'puts Time.now'
  
  get '/parking_locations', to: 'parking_locations#index'

  get   '/cars/view/comment/:vin', to:       'car#show'
  get   '/cars/car_rental_history/:vin', to: 'car_rental_history#index' 
  get   '/cars/rent/:date', to:              'car#availability'
  post   '/cars/rent/select', to:              'car#reserve'
  post  '/new_comment', to:                  'car#createComment'
  post  '/cars/create', to:                  'car#create'
  get   '/cars/view', to:                    'car#index'

  get'/admin/members', to: 'member#index'
  get'/member/:id/rental_history', to: 'member_rental_history#index'

  get'/admin', to: 'admin#index'

  get   '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'

  get   '/logout',  to: 'sessions#destroy'



  post   '/signup',   to: 'sessions#signup'
  get    '/logout',  to: 'sessions#destroy'


end
