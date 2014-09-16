Rails.application.routes.draw do
  resources :people
  resources :phone_numbers
  resources :email_addresses
  resources :companies
end
