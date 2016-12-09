Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :goals, except: [:index]
  resources :users, only: [:create, :new, :update] do
    get :goals_list, on: :collection
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  get '/auth/twitter', as: :sign_in_with_twitter
  get '/auth/twitter/callback' => 'callbacks#twitter'

  get '/auth/facebook', as: :sign_in_with_facebook
  get '/auth/facebook/callback' => 'callbacks#facebook'

  resources :passwords, only: [:edit, :update, :new] do
    post :link, on: :collection
    get :forgot_password, on: :collection
    patch :update_password, on: :collection
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :goals, only: [:show, :create]
    end
  end

  get '/api/v1/goals/' => 'api/v1/goals#goals_list'
  post '/api/v1/goals/:id/' => 'api/v1/goals#update_done'
  delete '/api/v1/goals/:id/' => 'api/v1/goals#delete_goal'
  patch '/api/v1/goals/:id/' => 'api/v1/goals#update_edited_goal'
end
