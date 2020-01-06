Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
Rails.application.routes.draw do
  root  "items#index"
  resources :items
  resources :users , only: [:index] do
    collection do
      get 'profile'
      get 'exhibiting'
      get 'product'
      get 'progress'
      get 'completed'
    end
  end
end