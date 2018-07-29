Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :apidocs, only: :index
  resources :publisher do
    get 'shops'
  end

  resources :shops do
    post 'sell_book'
  end
end
