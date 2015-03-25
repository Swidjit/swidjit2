Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :subscriptions, :only => [:create,:destroy,:index]
    resources :flags
    member do
      post 'upload_file'
      post 'update_tags'
      get 'invoices', :as => 'invoices'
    end
    collection do
      post 'autocomplete'
    end
  end

  resources :charges do
    collection do
      post 'transfer'
    end
  end

  resources :requests, :only => [:create,:destroy]

  resources :websites, :only => [:create] do
    collection do
      post 'scrape'
    end
  end

  resources :conversations, :only => [:create,:show,:index, :destroy] do
    resources :messages, :only => [:create]
  end

  resources :users, :only => [:edit, :update] do
    resources :conversations, :only => :index
  end

  resources :claims, :only => [:create, :destroy] do
    post 'accept'
    post 'deny'
    post 'payment'
    post 'finish_payment'
  end

  resources :invoices do
    member do
      post 'pay'
    end
    collection do
      post 'pay'
    end
  end
  resources :items do
    resources :watches, :only => [:create]
    resources :images, :only => [:destroy]
    resources :recurrences, :only => [:create, :destroy]
    resources :rsvps, :only => [:create, :destroy]
    resources :flags, :only => [:create]

    collection do
      get 'autocomplete_topic_search'
      get 'filter'
      get 'autocomplete_item_title'
    end
    member do
      post 'upload_file'
      post 'create_or_destroy_reaction'
      post 'set_request_id'
    end

  end
  resources :freepiles
  resources :topics
  resources :events do
    collection do
      get :day
    end
  end
  resources :products do
    resources :offers, :only => [:create, :destroy]
  end
  resources :swap_products do
    resources :swap_offers, :only => [:create, :destroy]
  end
  resources :questions do
    resource :response, :only => [:create, :destroy]
  end


  resources :comments, :only => [:create, :destroy]
  root :to => 'pages#home'
  get '/:display_name' => 'users#show', :as => :profile
  get 'pages/:page_name' => 'pages#index', :as => :pages
end
