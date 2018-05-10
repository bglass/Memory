Rails.application.routes.draw do

  get 'tags'                 => 'tag#tree'
  get 'folders'              => 'folder#tree'
  get 'notes'                => 'note#tree'
  # post '/display'            => 'note#display'
  get 'note/:id'             => 'note#view'
  get '/'                    => 'main#view'
  get "/static/:page"        => 'static_pages#show'
  get '/display'            => 'note#displayselect'

  mount ActionCable.server => '/cable'  # ???




end
