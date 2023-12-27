# frozen_string_literal: true

Rails.application.routes.draw do
  get 'payments/create'
  namespace :admin do
    resources :items
  end

  root 'items#index'
  # get '/admin' => 'admin#index'
  # get '/admin/new' => 'admin#new'
  # get '/admin/:id' => 'admin#show'
  # post '/admin' => 'admin#create'
  # get '/admin/:id/edit' => 'admin#edit'
  # patch '/admin/:id' => 'admin#update'
  # delete '/admin/:id' => 'admin#destroy'

  post '/cart/:id' => 'cart_items#create'
  get '/cart' => 'cart_items#index'
  delete '/cart/:id' => 'cart_items#destroy'

  post '/payment' => 'payments#create'

  # get '/' => 'items#index'
  get '/items/:id' => 'items#show'
end
