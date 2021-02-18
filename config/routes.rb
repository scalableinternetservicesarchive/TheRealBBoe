Rails.application.routes.draw do


  root 'homepage#index'
  get 'user', to: 'user#index'
  get 'signup', to: 'user#create'

end
