Rails.application.routes.draw do
  devise_for :users
  resources :items do
    resources :watches, :only => [:create]
  end
  resources :freepiles
  resources :comments
  root :to => 'pages#home'
  get 'pages/:page_name' => 'pages#index', :as => :pages
end
