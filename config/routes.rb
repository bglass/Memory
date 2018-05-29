Rails.application.routes.draw do

  get 'tags'                 => 'tag#tree'
  get 'folders'              => 'folder#tree'
  get 'notes'                => 'note#tree'
  # post '/display'            => 'note#display'
  get 'note/:id'             => 'note#view'
  get '/'                    => 'main#view'
  get "/static/:page"        => 'static_pages#show'
  get '/display'             => 'note#display'
  get '/book'                => 'note#book'
  get '/editor/'             => 'note#editor'
  get "/elm"                 => 'main#elm'
  get "/model"               => 'main#model'

end
