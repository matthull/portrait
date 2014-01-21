Portrait::Application.routes.draw do
  resources :sites do
    post 'api', :on=>:collection
  end
  
  resources :users

  resources :sessions, only: [:new, :create]
  get 'logout', to: 'sessions#destroy', as: :logout
  
  post '/'=>'sites#api',  as: 'api'
  get  '/'=>'home#index', as: 'root'  
end
