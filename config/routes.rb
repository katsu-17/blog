Rails.application.routes.draw do
  devise_for :users, controllers: {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions',
  :passwords => 'users/passwords'
}

  resources :articles do
    resources :comments, only:[:create, :destroy]
  end
  root   'articles#index'
  get "search" => "searches#search"
end
