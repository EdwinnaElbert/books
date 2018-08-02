Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :apidocs, only: :index

  resources :publishers, defaults: { format: 'json' } do
    member do
      get :shops
    end
  end

  resources :shops do
    member do
      put :sell_books
    end
  end
end
