Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :apidocs, only: :index

  resources :publishers, defaults: { format: "json" } do
    # get 'shops', to: 'publisher#shops'
    member do
      get :shops
    end
  end

  # resources :shops do
  #   post 'sell_book'
  # end
end
