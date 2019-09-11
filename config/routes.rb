Rails.application.routes.draw do
  root to: redirect("admin/members", status: 302)

  namespace :admin do
    resources :members
    resources :ships

    root to: redirect("admin/members", status: 302)
  end
end
