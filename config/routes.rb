Rails.application.routes.draw do
  resources :sessions

  resources :users

  get 'welcome/index'

  root 'welcome#index'
end
