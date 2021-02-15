Rails.application.routes.draw do

  get 'user', to: 'user#index'
  get 'signup', to: 'user#create'
  post 'room', to: 'rooms#create'
end
