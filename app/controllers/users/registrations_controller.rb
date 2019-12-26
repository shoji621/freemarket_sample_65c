class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only:  [:phone]
  before_action :set_user, except: [:phone,:validates_phone, :create]
  before_action :validates_phone, only: :phone_authen # phoneのバリデーション
 
  def index
  end

  def profile
  end

  def phone
    binding.pry
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
    @address = Address.new(session[:address_attributes])
  end

  # 新規登録時のクレカと登録未実装の為
  # def card
  #   session[:address_attributes] = user_params[:address_attributes]
  # end

  # エラーメッセージの表示は保留
  def create
    session[:address_attributes] = user_params[:address_attributes]
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(session[:address_attributes])
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      redirect_to address_path and return
    end
    @user.build_address(@address.attributes)
    @user.save
    sign_in(:user, @user)
    render :complete
  end

  # cardアクション内のsessionを完了画面に変更
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
      address_attributes: [:id,:zipcode,:prefecture_id,:city,:block,:building,:phone]
      # card_attributes: [:id,:user_id,:customer_id]
    ) 
  end

  def set_user
    @user = User.new
    @user.build_address
    # @user.build_card
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end  
end
