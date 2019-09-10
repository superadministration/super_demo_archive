Rails.application.routes.draw do
  namespace :admin do
    resources :members
    resources :ships
  end
end
