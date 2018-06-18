Rails.application.routes.draw do
  resources :channels
  resources :discussions do
    resources :replies
  end

  root 'discussions#index'

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
end
end
