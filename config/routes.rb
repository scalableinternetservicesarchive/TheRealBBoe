Rails.application.routes.draw do

  get 'user', to: 'user#index'
  get 'signup', to: 'user#create'

end
