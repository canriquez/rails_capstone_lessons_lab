
Rails.application.routes.draw do

  root to: 'welcome#index'

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  resources :groups # here we create the resource course(group)
  resources :transactions, only: [ :index, :new, :create, :edit, :delete, :destroy  ]

  get 'enrolled/:id', to: 'enrolled#enrolled'
  get 'to_enroll/:id', to: 'to_enroll#enrolled'
  
  resources :enrolls, only: [ :new, :create ]

  
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
