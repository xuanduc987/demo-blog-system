Rails.application.routes.draw do
  resources 'users'

  root 'static_pages#home'

  get 'signup' => 'users#new'
end
