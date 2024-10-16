Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # RESTful routes for employees
  namespace :api do
    namespace :v1 do
      resources :employees, only: [:index, :show, :create, :update, :destroy] do
        # Custom route for tax deduction
        member do
          get 'tax_deduction'
        end
      end
    end
  end
end
