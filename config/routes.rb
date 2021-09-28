Rails.application.routes.draw do
    namespace :api do
        resources :users, only: [] do
            resources :bookings, except: [ :new, :edit ]
        end
    end

    root 'application#index'
end
