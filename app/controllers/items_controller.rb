class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy, :show] 

  def index
    @items = Item.includes(:images).order('created_at DESC').limit(20)

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
    # ブランドはstrでparamsにのってくるので、該当するbrand_idを探す
    @category_id = Category.find_by(name: params[:item][:category_id]).id
    @item = Item.new(item_params.merge(category_id: @category_id))
    if @item.save
      redirect_to root_path
    else
      flash.now[:alert] = @item.errors.full_messages
      redirect_to action: 'new'
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(item.id)
    else
      flash.now[:alert] = @item.errors.full_messages
      render :edit
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
    params.require(:item).permit(:name, :text, :condition_id, :postage_id, :prefecture_id, :shipping_day_id, :price, :buyer_id, images_attributes:  [:src, :_destroy]).merge(seller_id: current_user.id)
   end

   def set_item
    @item = Item.find(params[:id])
  end

end
