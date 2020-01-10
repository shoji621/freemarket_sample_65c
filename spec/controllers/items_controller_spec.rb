require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe 'GET #index' do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #create' do
    it "renders the :new template" do
      get :create
      expect(response).to render_template :create
    end
  end

  describe 'GET #edit' do
    it "renders the :edit template" do
      get :edit
      expect(response).to render_template :edit
    end
  end

  describe 'GET #update' do
    it "renders the :update template" do
      get :update
      expect(response).to render_template :update
    end
  end

  describe 'GET #show' do
  it "renders the :show template" do
    get :show
    expect(response).to render_template :show
  end
 end
end
