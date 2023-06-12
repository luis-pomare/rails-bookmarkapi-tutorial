Rails.application.routes.draw do
  root 'bookmarks#index'
  resources :bookmarks
  get 'health/index'
end
