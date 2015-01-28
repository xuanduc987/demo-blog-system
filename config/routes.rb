Rails.application.routes.draw do
  get 'sessions/new'

  resources 'users' do
    member do
      get :following, :followers
    end
  end
  resources 'entries', only: [:create, :destroy, :show]
  resources :relationships, only: [:create, :destroy]

  root 'static_pages#home'

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
