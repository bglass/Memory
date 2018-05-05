Rails.application.routes.draw do

  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'tags'                 => 'tag#index'
  get 'folders'              => 'folder#index'
  get 'notes'                => 'note#index'
  get 'note/:id'             => 'note#view'
  get '/'                    => 'main#view'
  get "/static/:page"        => 'static_pages#show'
  post '/display'          => 'note#display'




end
