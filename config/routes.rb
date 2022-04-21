Rails.application.routes.draw do
  get '/word', to: 'words#get'
  post '/register', to: 'users#create'
  post '/login', to: 'sessions#create'
  post '/logout',   to: 'sessions#destroy'
  get '/get_current_user', to: 'users#get_current_user'
end
