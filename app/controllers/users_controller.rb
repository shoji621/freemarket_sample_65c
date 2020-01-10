class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end
  
  def exhibiting
    @items = Item.where(params[:id])
    @image = Image.find_by(item_id: params[:id])
  end

  def progress
  end

  def completed
  end

  def edit
  end

  def update
  end

  def introduction
  end

  def logout
  end


end
