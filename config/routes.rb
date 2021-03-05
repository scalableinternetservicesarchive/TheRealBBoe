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
    get 'get_rooms', to: 'members#get_rooms'

    # restaurant operations
    get 'restaurant', to: 'restaurants#show'
    get 'restaurants', to: 'restaurants#index'
    post 'restaurant', to: 'restaurants#create'
    get 'restaurant/seed', to: 'restaurant#seed' 

    # room
    post 'room/join', to: 'rooms#join_room'
    get 'room/votes/:room_token', to: 'rooms#room_votes'
    get 'room/:token', to: 'rooms#roompage'
    post 'room', to: 'rooms#create'
    get 'rooms', to: 'rooms#index'
    

    # location
    post 'location', to: 'locations#create'
    get 'locations', to: 'locations#index'

    # homepage
    root 'homepages#index'
    post 'guest_signin', to: 'homepages#signin_as_guest'
    get 'log_out', to: 'homepages#log_out'
    post 'signin', to: 'homepages#signin'
    post 'addGuestName', to: 'homepages#add_guest_name'
    get 'reset_database', to: 'homepages#reset_db'


end
