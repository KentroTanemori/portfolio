Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'root#top'
  get 'top' => "root#top"
  resources :root
  #root 'post_images#index'
  resources :post_images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
  	resource :favorites, only: [:create, :destroy]
  	resources :post_comments, only: [:create, :destroy]
  end
    resources :users, only: [:show, :index, :edit, :update]

    resources :users do
    	member do
    	 get :following, :followers
    	end
    end
    resources :relationships, only: [:create, :destroy]

end
