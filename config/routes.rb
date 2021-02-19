Rails.application.routes.draw do
    root 'homepage#index'
    get 'user', to: 'user#show'
    get 'users', to: 'user#index'
    post 'user', to: 'user#create'
    delete 'user', to: 'user#destroy'


    post 'room', to: 'rooms#create'
    get 'room/createRoomPage', to: 'rooms#createRoomPage'


    post 'member', to: 'members#create'

    get 'addLocation/:name', to: 'locations#create'

end
