Rails.application.routes.draw do
  resources :books do
    resources :borrowings, only: [:new, :create]
    member do
      post 'return', to: 'borrowings#return'
    end
  end

  get 'borrowers/:name', to: 'borrowings#history', as: 'borrower_history'

  root 'books#index'
end
