Rails.application.routes.draw do
  resources :groups, only: [ :new, :create, :index, :show ]  #here we create the resource course(group)
  root to: 'welcome#index'
end
