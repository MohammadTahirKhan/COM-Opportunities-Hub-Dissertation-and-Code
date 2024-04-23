Rails.application.routes.draw do
  
  resources :posts do
    member do
      patch :approve
      patch :save_post_ids
      patch :unsave_post_ids
      patch :notifications
    end
  end

  resources :email_drafts do
    collection do
      get :new
      patch :add_selected_post_ids
    end
  end

  resources :admin, only: %i[index edit update destroy]
  resources :profile, only: %i[index show edit update destroy]
  


  devise_for :users, components: {sessions: 'sessions', omniauth_callbacks: 'omniauth_callbacks'}
  devise_scope :user do
    get 'users/sign_out' => "devise/sessions#destroy"
    patch 'users/edit' => "devise/registrations#edit"
  end

  root "pages#home"
  
  
end
