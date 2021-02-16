Rails.application.routes.draw do

  get 'user', to: 'user#index'
  get 'signup', to: 'user#create'


  post 'room', to: 'rooms#create'
  get 'room/createRoomPage', to: 'rooms#createRoomPage'


  post 'member', to: 'members#create'

  get 'addLocation/:name', to: 'locations#create'
end
