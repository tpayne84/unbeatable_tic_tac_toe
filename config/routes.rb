Ttt::Application.routes.draw do
  root to: 'games#index'
  
  resources :squares, :only => [:update]
  resources :games do
    resources :players, :only => [:new, :create, :update, :destroy]
    resources :boards, :only => [:new, :create, :update, :destroy] do
      resources :squares, :only => [:new, :create, :update, :destroy]
    end
  end
end
