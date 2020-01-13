class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def favorite
    @user = User.find(current_user.id)
    @favorite_items = @user.favorite_items.includes(:images).order('created_at DESC')
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
    @user = User.find(params[:id])
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

end
