
Rails.application.routes.draw do
  devise_for :users

  resources :groups # here we create the resource course(group)
  resources :transactions, only: [ :index, :new ]

  get 'enrolled/:id', to: 'enrolled#enrolled'

  
  resources :groups do
    member do
      get 'confirm_destroy'
      get 'enrolled'
    end
  end

  root to: 'welcome#index'
end
