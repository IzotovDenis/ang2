Rails.application.routes.draw do

  require 'sidekiq/web'
    authenticate :user, lambda { |u| u.role == 'dev' } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users

  get '1c_import/:exchange_type' => "imports#index"
  post '1c_import/:exchange_type' => "imports#index" 

  root "app#index"

  get 'pricelist.zip' => "api/pricelists#download"

  namespace :api do
    resources :pricelists, :only =>[:index]
    resources :groups, :only =>[:index, :show] do
      collection do 
        get 'tree'
      end
    end
    resources :items, :only => [:show] do
      collection do
        get 'newest'
      end
    end
    resources :orders, :only => [:index, :show] do
      collection do
        get 'current'
        post 'forwarding'
        post 'add_items'
        post 'delete_items'
      end
    end
    resources :order_items do
      collection do
        post 'create_array'
      end
    end
    resources :offers, :only => [:index, :show]
    resources :find
    resources :users, :only => [:index, :update] do
      collection do
        patch 'update_password'
        get 'current'
      end
    end
    resources :brands, :only => [:index, :show]
    resources :posts, :only => [:show]
  end

  get 'dashboard' => "dashboard#index"

  namespace :dashboard do
    namespace :api do
      get "stat"
      resources :rates, :only => [:create]
      resources :orders
      resources :pricelists
      resources :activities do
        collection do
          get "user_online"
        end
      end
      resources :users do
        collection do
          post "update_role"
        end
      end
      resources :offers do
        collection do
          get "get_items"
        end
      end
      resources :groups do
        collection do
          get "tree"
          post "toggle"
        end
      end
      resources :banners do
        collection do
          post "sort"
        end
      end
      resources :currencies
      resources :posts do
        collection do
          post "sort"
        end
      end
      resources :folders
      resources :files
    end
  end

  get '*path', to: 'app#index'
end
