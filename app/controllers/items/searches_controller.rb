class Items::SearchesController < ApplicationController
  def index
    @items = Item.search(params[:keyword]).order('created_at DESC')
  end
end
