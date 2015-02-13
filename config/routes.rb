Rails.application.routes.draw do
  devise_for :users

  resources :users, :only => [:show]
  resources :items do
    resources :watches, :only => [:create]
    resources :images, :only => [:destroy]
    collection do
      get 'autocomplete_topic_search'
    end
    member do
      post 'upload_file'
      post 'create_or_destroy_reaction'
    end
  end
  resources :freepiles
  resources :comments
  root :to => 'pages#home'
  get 'pages/:page_name' => 'pages#index', :as => :pages
end
