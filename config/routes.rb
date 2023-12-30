# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :items
    resources :purchased_items
  end

  root 'items#index'
  get '/items/:id' => 'items#show'

  post '/cart/:id' => 'cart_items#create'
  get '/cart' => 'cart_items#index'
  delete '/cart/:id' => 'cart_items#destroy'

  get 'payments/create'
  post '/payment' => 'payments#create'
end
