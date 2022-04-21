if Rails.env === 'production' 
  Rails.application.config.session_store :cookie_store, key: 'cuvantar', domain: 'none_yet.no'
else
  Rails.application.config.session_store :cookie_store, key: 'cuvantar'
end