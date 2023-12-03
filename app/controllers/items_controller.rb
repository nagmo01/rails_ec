# frozen_string_literal: true

class ItemsController < ApplicationController
  def index
    @items = Item.all
  end
=begin
  def show
    items = Item.all
    @item = Item.find(params[:id])
    @items = []
    items.each do |item|
      unless item.id == @item.id
        @items.push(item)
      end
    end
  end
=end
  def show
    @items = Item.all
    @item = Item.find(params[:id])
    @items = @items.reject { |x| x.id == @item.id }
  end

end
