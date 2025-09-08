Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :barbershops do
    resources :barbers
    resources :appointments, only: [:index, :show]
    resources :branches do
      get :reports, on: :member
    end
  end

  resources :dashboards, except: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :super_admin
      get :owner
      get :barber
      get :customer
    end
  end
end
