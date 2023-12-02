# frozen_string_literal: true

class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @items = Item.all
    @item = Item.find(params[:id])
  end
end
