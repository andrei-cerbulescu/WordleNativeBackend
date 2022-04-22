Rails.application.routes.draw do
  get '/word', to: 'words#get'
  post '/login', to: 'authentication#login'
  get '/get_current_user', to: 'users#get_current_user'
end
