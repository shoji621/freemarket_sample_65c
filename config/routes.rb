Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions:      "users/sessions",
  }
  devise_scope :user do
    post    "sign_in",              to: "devise/sessions#new"
    delete  "sign_out",             to: "devise/sessions#destroy"
    get     "index",                to: "users/registrations#index"
    get     "profile",              to: "users/registrations#profile"
    get     "phone",                to: "users/registrations#phone"
    get     "phone_authentication", to: "users/registrations#phone_authen"
    get     "address",              to: "users/registrations#address"
    get     "creditcard",           to: "users/registrations#creditcard"
    get     "complete",             to: "users/registrations#complete"
    post    "complete",             to: "users/registrations#create"
  end

  root  "items#index"
  resources :items do
  collection do
    #Ajaxで動くアクションのルートを作成
    get 'get_category_children', defaults: { format: 'json' }
    get 'get_category_grandchildren', defaults: { format: 'json' }
    get     "confirmation"
    end
  end
  resources :users, only: [:index, :edit, :update,] do
  collection do
    get     "logout"
    get     "introduction"
    get 'profile'
    get 'exhibiting'
    get 'product'
    get 'progress'
    get 'completed'
  

    end
  end

  resources :card, only: [:new, :index, :create, :destroy]

end