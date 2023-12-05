# frozen_string_literal: true

Rails.application.routes.draw do

  get "/admin" => "admin#index"
  get "/admin/new" => "admin#new"
  get "/admin/:id" => "admin#show"
  post "/admin" => "admin#create"
  get "/admin/edit/:id" => "admin#edit"
  patch "/admin/update/:id" => "admin#update"
  delete "/admin/:id" => "admin#destroy"


  get '/' => 'items#index'
  get '/items/:id' => 'items#show'
end
