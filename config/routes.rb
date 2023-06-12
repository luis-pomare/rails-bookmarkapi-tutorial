Rails.application.routes.draw do
  resources :bookmarks
  get 'health/index'
end
