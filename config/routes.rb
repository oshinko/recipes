Rails.application.routes.draw do
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :articles do
    resources :comments
  end
  resources :comments

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :users, param: :nickname do
    resources :recipes
  end
  resources :recipes
  get '/pick', to: 'welcome#pick'
end
