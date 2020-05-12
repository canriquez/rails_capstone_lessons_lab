# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :groups # here we create the resource course(group)
  
  resources :groups do
    member do
      get 'confirm_destroy'
    end
  end

  root to: 'welcome#index'
end
