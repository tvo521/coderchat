Rails.application.routes.draw do
  resources :sessions

  resources :users do
    resources :messages
  end

  get 'welcome/index'

  root 'welcome#index'
end
