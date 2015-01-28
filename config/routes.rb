Rails.application.routes.draw do
  get 'sessions/new'

  resources 'users'
  resources 'entries', only: [:create, :destroy, :show]

  root 'static_pages#home'

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
