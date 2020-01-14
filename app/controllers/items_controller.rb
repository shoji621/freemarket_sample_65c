class ItemsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :set_item, only: [:edit, :update, :destroy, :show]
  before_action :move_to_index, only: [:edit, :update]
  def index
    @womens_category_ids = Category.joins(:items).where("ancestry LIKE ?", "1/%").ids
    @womens_categories = Item.where(category_id: @womens_category_ids ).order('created_at DESC').limit(10)

    @mens_category_ids = Category.joins(:items).where("ancestry LIKE ?", "219/%").ids
    @mens_categories = Item.where(category_id: @mens_category_ids ).order('created_at DESC').limit(10)
  end

  def new
    @item = Item.new
    @item.images.new
    #セレクトボックスの初期値設定
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
    @category_parent_array.unshift("---")
    # データベースから、親カテゴリーのみ抽出し、配列化
  end

  def create
    unless params[:item][:category_id] == "---"
      @item = Item.new(item_params)
      if @item.save
        redirect_to root_path
      else
        flash.now[:alert] = @item.errors.full_messages
        redirect_to new_item_path
      end
    end
  end

  def edit
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
    @category_parent_array.unshift("---")
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      flash.now[:alert] = @item.errors.full_messages
      redirect_to edit_item_path
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
    flash.now[:alert] = '削除できませんでした。'
    end
  end
  

  def show
    @images = Image.where(item_id: params[:id])
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
    @seller_items = Item.where(seller_id: @item.seller_id).order('created_at DESC').limit(6)
    @not_seller_items = Item.where.not(seller_id: @item.seller_id).order('created_at DESC').limit(6)
  end

  def confirmation
  end


  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  
  private
   def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :postage_id, :prefecture_id, :shipping_day_id, :price, :buyer_id, images_attributes: [:src, :_destroy, :id]).merge(seller_id: current_user.id)
   end

   def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if @item.seller.id != current_user.id
  end

end
