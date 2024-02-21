Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # devise_scope :user do
  #   get "sign_in", to: 'devise/sessions#new'
  #   post "sign_in", to: 'devise/sessions#create' 
  # end

  get "sign_in", to: 'sessions#new'
  post "sign_in", to: 'sessions#create' 

  delete "log_out", to: 'sessions#destroy'
  # Defines the root path route ("/")
  root "pages#home"
  
end
