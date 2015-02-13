Rails.application.routes.draw do
  devise_for :users

  resources :freepiles
  root :to => 'pages#home'
  get 'pages/:page_name' => 'pages#index', :as => :pages
end
