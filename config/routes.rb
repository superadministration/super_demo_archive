Rails.application.routes.draw do
  root to: redirect("admin/members")

  namespace :admin do
    resources :members
    resources :ships

    root to: redirect("admin/members")
  end
end
