require 'rails_helper'

describe Users::RegistrationsController do
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  context 'not log in' do
    describe 'GET #index' do
      it ':indexテンプレートを表示すること' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #profile' do
      it ':iprofileテンプレートを表示すること' do
        get :profile
        expect(response).to render_template :profile
      end
    end

    describe 'GET #phone' do
      it ':profileテンプレートを表示すること(バリデーションエラー)' do
        @user = build(:user)
        get :phone
        expect(response).to render_template :profile
      end
    end

    describe 'GET #address' do
      it ':addressテンプレートを表示すること' do
        get :address
        expect(response).to render_template :address
      end
    end

    describe 'GET #complete' do
      it ':completeテンプレートを表示すること' do
        get :complete
        expect(response).to render_template :complete
      end
    end

    describe 'POST #create' do
      it ':completeテンプレートを表示すること' do
        get :complete
        expect(response).to render_template :complete
      end
    end
  end

end
