Rails.application.routes.draw do
  resources :people
  resources :phone_numbers, only: [:new, :create, :edit, :update, :destroy]
  resources :email_addresses
  resources :companies
end
