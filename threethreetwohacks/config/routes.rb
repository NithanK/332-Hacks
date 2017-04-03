Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # homepage:
  root 'car#availability'
  # SET THE TIMEZONE IN THE CLI
  # TZ=EST ruby -e 'puts Time.now'
  
 


  # features for all users
  get   '/parking_locations', to:           'parking_locations#index'
  get   '/parking_locations/:location', to: 'parking_locations#availability'
  get   '/cars/view/comment/:vin', to:      'car#show'
  get   '/cars/view/:vin', to:              'car#show'
  get   '/cars/rent/:date', to:             'car#availability'
  post  '/cars/rent/select', to:            'car#reserve'
  post  '/cars/rent/unlock', to:            'car#unlock'
  post  '/cars/rent/return_car', to:        'car#return_car'
  post  '/new_comment', to:                 'car#createComment'
  get   '/member/profile', to:              'member#profile'
  get   '/member/reservations', to:         'member#reservations'

  # admin features
  # NOTE: restrict them to isAdmin
  get   '/admin/members', to:               'member#index'
  get   '/member/:id/rental_history', to:   'member_rental_history#index'
  get   '/admin', to:                       'admin#index'
  get   '/cars/view', to:                   'car#index'
  post  '/cars/create', to:                 'car#create'
  get   '/cars/car_rental_history/:vin', to:'car_rental_history#index' 
  post '/new_reply', to:                    "car#createReply"
  post  '/parking_locations/create', to:    'parking_locations#create'
  get  '/admin/reservations/',       to: 'member#adminReservationDatepicker'
  get  '/admin/reservations/:day',       to: 'member#adminReservations'
  

  # sesssions features
  get   '/login',   to:                     'sessions#new'
  post  '/login',   to:                     'sessions#create'
  post  '/signup',   to:                    'sessions#signup'
  get   '/logout',  to:                     'sessions#destroy'

end
