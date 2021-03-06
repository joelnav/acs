Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'accounts#index'

  resources :accounts do
    post 'contribute'
    post 'deposit'
    post 'transfer'
    post 'unlock'
  end
  resources :people
  resources :legal_people
end
