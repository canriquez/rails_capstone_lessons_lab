
Rails.application.routes.draw do

  root to: 'welcome#index'
  
  devise_for :users

  resources :groups # here we create the resource course(group)
  resources :transactions, only: [ :index, :new, :create, :edit, :delete, :destroy  ]

  get 'enrolled/:id', to: 'enrolled#enrolled'

  
  resources :transactions do
    member do
      get 'confirm_destroy'
      get 'enrolled'
    end
  end

  resources :groups do
    member do
      get 'confirm_destroy'
      get 'enrolled'
    end
  end


end
