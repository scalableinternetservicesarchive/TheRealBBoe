Rails.application.routes.draw do

  get 'user', to: 'user#index'
  get 'signup', to: 'user#create'
  post 'room/:location_id/:room_name/:host_id', to: 'room#create'
end
