Rails.application.routes.draw do
    get 'user', to: 'user#show'
    get 'users', to: 'user#index'
    post 'user', to: 'user#create'
    delete 'user', to: 'user#destroy'

    post 'guest_signin', to: 'homepage#signin_as_guest'

    root 'homepage#index'
end
