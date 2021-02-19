Rails.application.routes.draw do
    get 'user', to: 'user#show'
    get 'users', to: 'user#index'
    post 'user', to: 'user#create'
    delete 'user', to: 'user#destroy'

    get 'member', to: 'member#show'
    get 'members', to: 'member#index'
    post 'member', to: 'member#create'
    delete 'member', to: 'member#destroy'

    root 'homepage#index'
end
