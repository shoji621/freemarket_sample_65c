class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:update]

  def update
    @address = @user.address
    @address.update(building: address_attributes)
    if @address.update(building: address_attributes)
      redirect_to edit_user_path
    else
      ridirect_to root_path
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def address_attributes
      params.require(:address).permit(:building)
      params[:address][:building]
    end
end
