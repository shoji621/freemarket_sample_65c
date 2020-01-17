class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :seller_items , only: [:index, :exhibiting]
  before_action :buyer_items , only: :purchased
  before_action :set_user, only: [:edit, :update]

  def index
  end

  def favorite
    @user = User.find(current_user.id)
    @favorite_items = @user.favorite_items.includes(:images).order('favorites.created_at DESC')
  end

  def exhibiting
  end

  def progress
  end

  def completed
  end

  def purchasing
  end

  def purchased
  end

  def edit 
    if current_user == @user
      @address = @user.address
      @prefecture = @address.prefecture
    else
      redirect_to root_path
    end
  end

  def update
    if @user.update(users_params)
      redirect_to introduction_users_path
    end
  end

  def introduction
    @user = User.find(current_user.id)
  end

  def logout
  end

  private
  def users_params
   params.require(:user).permit(:nickname, :email, :introduction,:last_name , :first_name, :last_name_kana, :first_name_kana, :birthday, :phone_authy, :icon_image)
  end

  def seller_items
    @seller_items = Item.where(seller_id: current_user.id)
  end

  def buyer_items
    @buyer_items = Item.where(buyer_id: current_user.id)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
