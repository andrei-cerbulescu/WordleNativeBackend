Rails.application.routes.draw do
  get '/word', to: 'words#get'
  post '/suggest_word', to: 'words#create'
  post '/login', to: 'authentication#login'
  post '/rate_word', to: 'words#rate'
  get '/get_current_user', to: 'users#get_current_user'
end
