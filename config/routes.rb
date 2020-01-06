Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    # post    "sign_in",              to: "devise/sessions#new"
    # delete  "sign_out",             to: "devise/sessions#destroy"
    get     "index",                to: "users/registrations#index"
    get     "profile",              to: "users/registrations#profile"
    get     "phone",                to: "users/registrations#phone"
    get     "phone_authentication", to: "users/registrations#phone_authen"
    get     "address",              to: "users/registrations#address"
    get     "card",                 to: "users/registrations#card"
    get     "complete",             to: "users/registrations#complete"
    post    "complete",             to: "users/registrations#create"
  end

  root  "items#index"
  resources :items do
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
end