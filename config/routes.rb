Rails.application.routes.draw do
  resources :responders, except: [:new, :edit, :destroy]

  match '*path', to: 'errors#not_found', via: :all
end
