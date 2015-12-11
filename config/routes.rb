Rails.application.routes.draw do
  get 'users/login', to: 'users#login', as: 'login_users'
  delete 'users/logout', to: 'users#logout', as: 'logout_users'
  resources :users

  get 'welcome/index'

  root 'welcome#index'
end
