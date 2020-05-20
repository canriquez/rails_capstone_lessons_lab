
Rails.application.routes.draw do

  root to: 'welcome#index'

  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :transactions, only: [ :index, :new, :create, :edit, :delete, :destroy  ]
 

  get 'enrolled/:id', to: 'enrolled#enrolled'
  
  
  resources :enrolls, only: [ :create, :show ]
  
  get 'enrolar/:id', to: 'enrolled#enrolar'
  resources :transactions do
    member do
      get 'confirm_destroy'
      get 'enrolled'
    end
  end

  resources :groups # here we create the resource course(group)
  resources :groups do
    member do
      get 'confirm_destroy'
    end
  end


end
