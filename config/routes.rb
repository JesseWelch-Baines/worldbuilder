Rails.application.routes.draw do
  devise_for :users
  resources :users do
    member do
      get :preferences_form
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'application#main'

  resources :mentions, only: [:index]

  resources :worlds do
    member do
      post :change_to
      get :generate_elements
    end
    collection do
      post :create_from_nav
    end
  end

  resources :documents do
    member do
      get :writable_instances
    end
  end
  resources :characters do
    member do
      get :create_instance
    end
    collection do
      get :fetch
      post :create_from_document
      get :fields_index
    end
  end
  resources :locations do
    member do
      get :create_instance
    end
    collection do
      get :fetch
      post :create_from_document
      get :fields_index
    end
  end
  resources :items do
    member do
      get :create_instance
    end
    collection do
      get :fetch
      post :create_from_document
      get :fields_index
    end
  end
  resources :events do
    member do
      get :create_instance
    end
    collection do
      get :fetch
      post :create_from_document
      get :fields_index
    end
  end
  resources :paragraphs do 
    member do
      get :create_instance
      post :update_from_document
    end
    collection do
      post :create_from_document
    end
  end
  resources :writable_instances, only: [:destroy] do
    member do
      get :move_up
      get :move_down
      get :save_writable
    end
  end
  resources :writable_fields do
    member do
      get :move_up
      get :move_down
    end
  end
  resources :writables do
    collection do
      get :export_list
    end
  end
end
