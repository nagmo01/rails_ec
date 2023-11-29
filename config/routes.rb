# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admin/index'

  get '/' => 'items#index'
  get '/items/:id' => 'items#show'

  resources :tasks
end
