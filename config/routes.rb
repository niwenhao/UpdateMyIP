Rails.application.routes.draw do
  get 'login/display'

  post 'login/login'

  get 'login/logout'

  resources :host_addresses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
