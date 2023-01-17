Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :bookings, only: [] do
        collection do      
          post 'new', to: 'bookings#create', as: :new   # Expecting the route to be: /api/v1/bookings/new
          get :search
        end
        patch :update
        patch :cancel
      end
    end
  end
end
