class ItemsController < ApplicationController
  def index
  end

  def new
    #@item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
    
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
  end
end