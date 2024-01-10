Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    authenticated :user do
      root :to => 'categories#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'splash#new', as: :unauthenticated_root
    end
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :categories, only: [:index, :new, :create] do
    resources :payments, only: [:index, :new, :create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
end
