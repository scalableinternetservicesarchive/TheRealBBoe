Rails.application.routes.draw do
    get 'user', to: 'user#show'
    get 'users', to: 'user#index'
    post 'user', to: 'user#create'

    root 'homepage#index'
end
