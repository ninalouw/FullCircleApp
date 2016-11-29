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
end
