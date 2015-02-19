Rails.application.routes.draw do
  devise_for :users

  resources :users, :only => [:show] do
    resources :subscriptions, :only => [:create,:destroy,:index]
  end

  resources :items do
    resources :watches, :only => [:create]
    resources :images, :only => [:destroy]
    resources :recurrences, :only => [:create, :destroy]
    resources :rsvps, :only => [:create, :destroy]
    collection do
      get 'autocomplete_topic_search'
    end
    member do
      post 'upload_file'
      post 'create_or_destroy_reaction'
    end

  end
  resources :freepiles
  resources :topics
  resources :events do
    collection do
      get :day
    end
  end

  resources :questions do
    resource :response, :only => [:create, :destroy]
  end


  resources :comments, :only => [:create, :destroy]
  root :to => 'pages#home'
  get 'pages/:page_name' => 'pages#index', :as => :pages
end
