Rails.application.routes.draw do
   
    # user operations
    get 'user', to: 'users#show'
    get 'users', to: 'users#index'
    post 'user', to: 'users#create'
    delete 'user', to: 'users#destroy'

    # member operations
    get 'member', to: 'members#show'
    get 'members', to: 'members#index'
    post 'member', to: 'members#create'
    delete 'member', to: 'members#destroy'

    # homepage
    root 'homepages#index'
    post 'guest_signin', to: 'homepages#signin_as_guest'

    # room
    post 'room', to: 'rooms#create'
    get 'room/createRoomPage', to: 'rooms#createRoomPage'

    # location
    get 'addLocation/:name', to: 'locations#create'
end
