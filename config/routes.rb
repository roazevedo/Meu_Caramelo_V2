Rails.application.routes.draw do
#  devise_for :users

  devise_for :users, controllers: { registrations: 'registrations' }
  
  # post "users", to: "users#create"

   #get "users/:id", to: "users#show", as: :user
  # get "users/:id/edit", to: "users#edit", as: :edit_user
  # patch "users/:id", to: "users#update"

  get "matchs", to: "matchs#index"
  get "match", to: "matchs#show", as: :match

  root to: "pages#home"
  get "dashboard", to: "pages#dashboard", as: :dashboard

  # get "adoptionforms/:id", to: "adoptionforms#show", as: :adoptionform
  # get "adoptionforms/new", to: "adoptionforms#new", as: :new_adoptionform
  # post "adoptionforms", to: "adoptionforms#create"
  # get "adoptionforms/:id/edit", to: "adoptionforms#edit"
  # patch "adoptionforms/:id", to: "adoptionforms#update"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get 'my_applications', to: 'adoptions#my_applications'

  patch "adoptions/:id/update_status", to: "adoptions#update_status", as: :update_status
  patch "adoptions/:id/update_done", to: "adoptions#done", as: :done

  resources :adoption_forms, except: [:destroy]

  resources :animals, shallow: true do
    resources :adoptions, except: [:destroy]
  end

  # get 'favorites', to: 'bookmarks#favorites', as: 'favorites'
  get 'bookmarks', to: 'bookmarks#index', as: 'index'
  post 'bookmarks', to: 'bookmarks#create', as: 'bookmarks'
  delete 'bookmarks/:id', to: 'bookmarks#destroy', as: 'bookmark'

  resources :adoptions, shallow: true, except: [:destroy] do
    resources :testimonies, except: [:destroy]
  end

  resources :users, only: [:show]
    get "edit_user", to: "users#edit", as: :edit_user
    patch "update_user", to: "users#update", as: :update_user
end
