Rails.application.routes.draw do
  resources :messages

  resources :sessions

  resources :users

  get 'welcome/index'

  root 'welcome#index'
end
