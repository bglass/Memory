Rails.application.routes.draw do
  get "/static/:page"        => 'static_pages#show'
end
