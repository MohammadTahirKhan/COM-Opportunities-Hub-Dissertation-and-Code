Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # devise_scope :user do
  #   get "sign_in", to: 'devise/sessions#new'
  #   post "sign_in", to: 'devise/sessions#create' 
  # end
 
  # devise_for :users 
  # { sessions: 'sessions',
  #   omniauth_callbacks: 'omniauth_callbacks' 
  # }

  # get "sign_in", to: 'sessions#new'
  # post "sign_in", to: 'sessions#create' 
  # get "sign_up", to: 'sessions#new_registration'
  # post "sign_up", to: 'sessions#create_registration'

  
  devise_for :users, components: {registrations: 'registrations', sessions: 'sessions', omniauth_callbacks: 'omniauth_callbacks'}
  devise_scope :user do
    get 'users/sign_out' => "devise/sessions#destroy"
    patch 'users/edit' => "devise/registrations#edit"
  end

  # delete "log_out", to: 'sessions#destroy'
  # Defines the root path route ("/")
  root "sessions#new"
  # If a user is authenticated, redirect to home page
  authenticated :user do
    root "pages#home", as: :authenticated_root
  end
  
end
