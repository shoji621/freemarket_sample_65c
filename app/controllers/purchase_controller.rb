class PurchaseController < ApplicationController
  require 'payjp'
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_to_seller_user
  before_action :set_card

  layout "registrations"

  def index
    @image = Image.find_by(item_id: params[:format])
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_card_path
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)

      @card_brand = @default_card_information.brand
      case @card_brand
      when "Visa"
        @card_src = "//www-mercari-jp.akamaized.net/assets/img/card/visa.svg?2561606804"
      when "JCB"
        @card_src = "//www-mercari-jp.akamaized.net/assets/img/card/jcb.svg?2561606804"
      when "MasterCard"
        @card_src = "//www-mercari-jp.akamaized.net/assets/img/card/master-card.svg?2561606804"
      when "American Express"
        @card_src = "//www-mercari-jp.akamaized.net/assets/img/card/american_express.svg?2561606804"
      when "Diners Club"
        @card_src = "//www-mercari-jp.akamaized.net/assets/img/card/dinersclub.svg?2561606804"
      when "Discover"
        @card_src = "//www-mercari-jp.akamaized.net/assets/img/card/discover.svg?2561606804"
      end
    end
  end

  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount: @item.price, #支払金額を入力
    customer: @card.customer_id, #顧客ID
    currency: 'jpy' #日本円
    )
    @item.update(buyer_id: current_user.id)
    render :done #完了画面に移動
  end

  private

  def set_item
    @item = Item.find(params[:format])
  end

  def redirect_to_seller_user
    redirect_to root_path  if current_user.id == @item.seller_id
  end

  def set_card
    #Cardテーブルからpayjpの顧客IDを検索
    @card = Card.find_by(user_id: current_user.id)
  end

end