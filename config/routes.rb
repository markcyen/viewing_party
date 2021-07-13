Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/dashboard', to: 'dashboard#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/discover', to: 'discover#show'

  post '/friends', to: 'friends#create'
  get '/movies', to: 'movies#index'
end
