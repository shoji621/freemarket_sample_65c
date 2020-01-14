class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def create
    # 「current_userに関連したFavoriteクラスの新しいインスタンス」を作成
    favorite = current_user.favorites.build(item_id: params[:item_id])
    if favorite.save
    else
      flash.now[:alert] = favorite.errors.full_messages
    end
  end

  def destroy
    favorite = Favorite.find_by(item_id: params[:item_id], user_id: current_user.id)
    if favorite.destroy
    else
      flash.now[:alert] = '削除できませんでした。'
    end
  end

  private
  def set_item
   @item = Item.find(params[:item_id])
 end
end
