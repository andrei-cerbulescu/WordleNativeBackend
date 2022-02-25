Rails.application.routes.draw do
  get '/word', to: 'words#get'
end
