# frozen_string_literal: true

Rails.application.routes.draw do
  resources :groups, only: %i[new create index show] # here we create the resource course(group)
  root to: 'welcome#index'
end
