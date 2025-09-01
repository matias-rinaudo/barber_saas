Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :barbershops do
    resources :branches do
      resources :barbers, controller: 'branch_barbers', except: [:new, :edit, :show, :update]
      resources :appointments, only: [:index, :show]
      get :reports, on: :member
    end
  end
end