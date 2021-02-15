Rails.application.routes.draw do

  get 'user', to: 'user#index'
  get 'signup', to: 'user#create'
  get 'room/:location_id/:room_name/:host_id', to: 'rooms#create'
  get 'member/:rooms_id/:users_id', to: 'members#create'
end
