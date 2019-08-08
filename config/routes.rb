Rails.application.routes.draw do
  resources :appointments
  resources :beneficiary_schemes
  resources :citizens
  resources :departments
  resources :development_works
  resources :entity_statuses
  resources :events
  resources :feedbacks
  resources :notifications do 
    get :current, on: :collection
    get :specific_notification_form, on: :collection
    post :notify_specific_user, on: :collection
  end
  resources :positions
  resources :scheme_types
  resources :valid_types
  
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}
  authenticated :user do
    root 'pages#dashboard', as: :authenticated_root
  end

  resources :districts do 
    collection do
      get :place_form
      get :village_select
      post :create_place
      get :entity_form
      post :create_entity
    end
    member do
      get :panchayat_details
      patch :update_place
      patch :update_entity
    end
  end
  resources :users

  namespace :api do
    namespace :v1 do
      resources :appointments
      resources :beneficiary_schemes, only: [:index, :show]
      resources :commons do
        collection do
          get :status_list
          get :places
          get :departments
        end
      end
      resources :development_works, only: [:index, :show]
      resources :events, only: [:index, :show]
      resources :feedbacks
      resources :users do        
        collection do
          get :exists
          get :is_complete
          get :me
          post :otp
          post :otp_verify
          get :positions
          post :reset_password
          post :sign_in
          delete :sign_out
        end
      end
    end
  end
  
  get "users/suggest", to: "users#suggest"
  get "places/suggest", to: "districts#suggest"
  get "privacy_policy", to: "pages#pp"
  root "pages#index"
end
