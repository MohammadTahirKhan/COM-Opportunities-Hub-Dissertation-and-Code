Rails.application.routes.draw do
  resources :posts do
    member do
      patch :approve
    end
  end
  

  # resources :regular_posts, only: %i[index] do
  #   collection do
  #     get :upcoming
  #     get :recent
  #     get :archives
  #   end
  # end
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
  root "pages#home"
  
  
end
