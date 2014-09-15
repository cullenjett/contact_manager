Rails.application.routes.draw do
  resources :people
  resources :phone_numbers
  resources :email_address
end
