# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :items
  end

  # get '/admin' => 'admin#index'
  # get '/admin/new' => 'admin#new'
  # get '/admin/:id' => 'admin#show'
  # post '/admin' => 'admin#create'
  # get '/admin/:id/edit' => 'admin#edit'
  # patch '/admin/:id' => 'admin#update'
  # delete '/admin/:id' => 'admin#destroy'

  get '/' => 'items#index'
  get '/items/:id' => 'items#show'
end
