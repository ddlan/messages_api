Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      #/api/v1/users
      resource :users, only: [:update]

      # /api/v1/phones
      resource :phones, only: [:create]

      # GET /api/v1/verification_code
      resource :verification_code, only: [:show], controller: 'phones', to: 'phones#verification_code'

      scope 'auth' do
        # /api/v1/login
        post 'login', to: 'authenticated#login'
      end
    end
  end
end
