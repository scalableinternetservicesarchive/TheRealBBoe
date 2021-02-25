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
    post 'member/update_vote', to: 'members#update_member_votes'

    # restaurant operations
    get 'restaurant', to: 'restaurants#show'
    get 'restaurants', to: 'restaurants#index'
    post 'restaurant', to: 'restaurants#create'

    # room
    post 'room/join', to: 'rooms#join_room'
    get 'room/:token', to: 'rooms#roompage'
    post 'room', to: 'rooms#create'
    

    # location
    post 'location', to: 'locations#create'
    get 'locations', to: 'locations#index'

    # homepage
    root 'homepages#index'
    post 'guest_signin', to: 'homepages#signin_as_guest'

    
end
