Rails.application.routes.draw do
   
    get 'user', to: 'user#show'
    get 'users', to: 'user#index'
    post 'user', to: 'user#create'
    delete 'user', to: 'user#destroy'

    post 'guest_signin', to: 'homepages#signin_as_guest'

    post 'room', to: 'rooms#create'
    get 'room/createRoomPage', to: 'rooms#createRoomPage'


    post 'member', to: 'members#create'

    get 'addLocation/:name', to: 'locations#create'

    get 'member', to: 'member#show'
    get 'members', to: 'member#index'
    post 'member', to: 'member#create'
    delete 'member', to: 'member#destroy'

    root 'homepages#index'

end
