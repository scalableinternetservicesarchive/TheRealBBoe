Rails.application.routes.draw do

  get 'user', to: 'user#index'
  get 'signup', to: 'user#create'
  post 'room', to: 'rooms#create'
  get 'room/index', to: 'rooms#index'
  get 'new/', to: 'rooms#new', as: :new_path
end
