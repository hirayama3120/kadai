Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   namespace :api, { format: 'json' } do
#     resources :users, only: [:index, :create, :update, :update]
#   end
# 
#   resources :users, only: [:index, :create, :update, :update]
#   root to: 'users#index'
  namespace :api, { format: 'json' } do
    get '/users', to: 'users#index'
    post '/users', to: 'users#create'
    get '/users/:id', to: 'users#show'
    patch '/users/:id', to: 'users#update'
    put '/users/:id', to: 'users#update'
    delete '/users/:id', to: 'users#nullify'
  end

  get '/api-docs', to: 'api_docs#index'
  
  root to: 'users#index'
end