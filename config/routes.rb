Rails.application.routes.draw do
  resources :devices
  devise_for :users, controllers: { registrations: "registrations" }
  resources :user_apps
  resources :messages
  resources :apps
  resources :users
  
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  get 'users/:id/edit_apps', to: 'users#edit_apps', as: :edit_apps
  post 'users/:id/edit_apps', to: 'users#update_uapps', as: :update_uapps

  get 'users/:id/edit_user_apps_1', to: 'users#edit_user_apps_1', as: :edit_user_apps_1
  post 'users/:id/edit_user_apps_1', to: 'users#update_uapps_1', as: :update_uapps_1
  
  get 'users/:id/edit_user_apps_2', to: 'users#edit_user_apps_2', as: :edit_user_apps_2
  post 'users/:id/edit_user_apps_2', to: 'users#update_uapps_2', as: :update_uapps_2

  get 'users/:id/edit_user_apps_3', to: 'users#edit_user_apps_3', as: :edit_user_apps_3
  post 'users/:id/edit_user_apps_3', to: 'users#update_uapps_3', as: :update_uapps_3

  get 'users/:id/edit_device_questions', to: 'users#edit_device_questions', as: :edit_device_questions
  post 'users/:id/edit_device_questions', to: 'users#update_device_questions', as: :update_device_questions

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
