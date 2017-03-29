Rails.application.routes.draw do

  namespace :admin do
    # Admin root
    root 'home#index'

    # Menu
    post 'menu_update', to: 'home#menu_update'

    # Set homepage
    get 'set_home/:id', to: 'home#set_home', as: 'set_home'

    # Set settings
    post 'set_settings', to: 'home#set_settings', as: 'set_settings'

    # Pages
    resources :pages, only: [:create, :update, :destroy]

    #Links
    resources :links, only: [:create, :update, :destroy]
  end

  #Root
  root 'pages#show', defaults: { id: Setting.home }

  # Login
  get  'login',  to: 'sessions#new'
  post 'login',  to: 'sessions#create'
  get  'logout', to: 'sessions#destroy'

  # Pages
  get 'not_found', to: 'pages#not_found'
  Page.all.each do |p|
    get p.slug, to: 'pages#show', defaults: { id: p.id }
  end

end