Rails.application.routes.draw do
  get 'login/display'

  post 'login/login'

  get 'login/logout'

  resources :host_addresses
  
  get 'host_addresses/dig_host/:hostname', to: 'host_addresses#dig_host'

  post 'host_addresses/setup_host', to: 'host_addresses#setup_host'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
