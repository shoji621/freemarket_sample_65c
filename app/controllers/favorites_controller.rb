class FavoritesController < ApplicationController
  def create
    # 「current_userに関連したFavoriteクラスの新しいインスタンス」を作成
    favorite = current_user.favorites.build(item_id: params[:item_id])
    if favorite.save
      redirect_to item_path(params[:item_id])
    else
      flash.now[:alert] = favorite.errors.full_messages
      redirect_to item_path(params[:item_id])
    end
  end

  def destroy
    favorite = Favorite.find_by(item_id: params[:item_id], user_id: current_user.id)
    if favorite.destroy
      redirect_to item_path(params[:item_id])
    else
      flash.now[:alert] = '削除できませんでした。'
      redirect_to item_path(params[:item_id])
    end
  end
end
