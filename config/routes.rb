Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
 root to: "prototypes#index"
 resources :prototypes, only: [:create, :new, :show, :edit, :update, :destroy]

 resources :prototypes do
   resources :comments, only: [:create]
 end

 resources :users, only: :show

end