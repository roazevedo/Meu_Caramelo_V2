Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  get "matchs", to: "matchs#index"
  get "match", to: "matchs#show", as: :match

  root to: "pages#home"
  get "dashboard", to: "pages#dashboard", as: :dashboard

  get "up" => "rails/health#show", as: :rails_health_check

  get 'my_applications', to: 'adoptions#my_applications'

  patch "adoptions/:id/update_status", to: "adoptions#update_status", as: :update_status
  patch "adoptions/:id/update_done", to: "adoptions#done", as: :done

  resources :adoption_forms, except: [:destroy]

  resources :animals, shallow: true do
    resources :adoptions, except: [:destroy]
  end

  resources :chatrooms, only: [:show, :create] do
    resources :messages, only: [:create]
  end

  resources :animals, only: [:show] do
    resources :chatrooms, only: [:create]
  end

  get 'bookmarks', to: 'bookmarks#index', as: 'index'
  post 'bookmarks', to: 'bookmarks#create', as: 'bookmarks'
  delete 'bookmarks/:id', to: 'bookmarks#destroy', as: 'bookmark'

  resources :adoptions, shallow: true, except: [:destroy] do
    resources :testimonies, except: [:destroy]
  end

  resources :users, only: [:show]

  get "edit_user", to: "users#edit", as: :edit_user
  patch "update_user", to: "users#update", as: :update_user

  get "/chatrooms/unread_count", to: "chatrooms#unread_count"
end
