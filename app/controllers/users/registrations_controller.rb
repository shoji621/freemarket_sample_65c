class Users::RegistrationsController < Devise::RegistrationsController
  require "payjp"
  before_action :configure_sign_up_params, only:  [:phone]
  before_action :set_user, except: [:phone,:validates_phone, :create]
  before_action :validates_phone, only: :phone_authen # phoneのバリデーション

  layout "registrations"

  def index
  end

  def profile
  end

  def phone
    params[:sns_auth] ? params[:user][:password] = Devise.friendly_token : "" ;
    @user = User.new(sign_up_params)
      unless @user.valid?
        flash.now[:alert] = @user.errors.full_messages
        render :profile and return
      end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
  end

  def phone_authen
    session["devise.regist_data"]["user"]["phone_authy"] = params[:user][:phone_authy]
  end

  def validates_phone
    # phoneで入力された値をsessionに保存
    session["devise.regist_data"]["user"]["phone_authy"] = params[:user][:phone_authy]
    # バリデーション用に、仮でインスタンスを作成する
    @user = User.new(session["devise.regist_data"]["user"])
    # 仮で作成したインスタンスのバリデーションチェックを行う
    unless @user.valid?(:validates_phone)
      flash.now[:alert] = @user.errors.full_messages
      render :phone and return
    end
  end 

  def address
    @address = Address.new
  end

  def creditcard
    @address = Address.new(user_params[:address_attributes])
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      redirect_to address_path and return
    end
    session[:address_attributes] = user_params[:address_attributes]
  end

  # エラーメッセージの表示は保留
  def create
    binding.pry
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    if params['payjp-token'].blank?
      render :creditcard
    else
      @user = User.new(session["devise.regist_data"]["user"])
      @address = Address.new(session[:address_attributes])
      @user.build_address(@address.attributes)
      @user.save
      customer = Payjp::Customer.create(card: params['payjp-token'])
      @card = Card.new(user_id: @user.id, customer_id: customer.id, card_id: customer.default_card)
      @card.save
      sign_in(:user, @user)
      render :complete
    end 
  end

  def complete
  end
  
  private
  
  def user_params
    params.require(:user).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :nickname,
      :email,
      :gender,
      :birthday,
      :phone_authy,
      :introduction,
      :icon_image,
      :password,
      address_attributes: [:id,:zipcode,:prefecture_id,:city,:block,:building,:phone],
    ) 
  end

  def set_user
    @user = User.new
    @user.build_address
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end  
end
