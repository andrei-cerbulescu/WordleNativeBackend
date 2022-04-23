Rails.application.routes.draw do
  get '/word', to: 'words#get'
  post '/suggest_word', to: 'words#create'
  post '/rate_word', to: 'words#rate'

  post '/login', to: 'authentication#login'

  get '/get_current_user', to: 'users#get_current_user'
  post 'register', to: 'users#create'
end
