Rails.application.routes.draw do
	
  get 'initializer', to: 'gateway_auths#index', via: :all

  get 'make_payment', to: 'gateway_auths#make_payment'

  get 'dashboard', to: 'dashboard#index'

  # resources :gateway_auths, only: [:new, :create, :update, :edit]

  scope module: 'users' do
    resources :confirmations, only: [:edit]
    resources :password_resets, only: [:new, :create, :update, :edit]
	  resources :sessions, only: [:new, :create, :destroy] 
	  resources :registrations, only: [:new, :create]
	end

  scope module: 'accounts' do
    # resources :funds, only: [:index, :create, :update]
    resources :transfers, only: [:index, :create]
    resources :banks, only: [:index, :create, :update, :edit, :destroy, :new]
  end

  scope module: 'balance_card' do
    resources :funds, only: [:index, :create, :update]
  end

  resources :users, only: [:edit, :update, :show, :destroy]

  get 'setting', to: 'users#edit'
	
	get 'signin', to: 'users/sessions#new'
	get 'signup', to: 'users/registrations#new'
	get 'signout', to: 'users/sessions#destroy'

	root 'users/sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
