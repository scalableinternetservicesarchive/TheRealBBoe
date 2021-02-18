Rails.application.routes.draw do

    # get 'user', to: 'user#index'
    # get 'signup', to: 'user#create'

    get 'user', to: 'user#show'
    get 'users', to: 'user#index'
    post 'user', to: 'user#create'
    delete 'user', to: 'user#destroy'
end
