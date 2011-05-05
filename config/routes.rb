Sgss::Application.routes.draw do
  #todas rotas necessarias para rodar o authlogic
  root :to => "user_sessions#new"

  resources :users
  match "join" => "users#new"

  resource :account, :controller => "users"

  resource :user_session
  match "login" => "user_sessions#new"
  match "logout" => "user_sessions#destroy"

  #aqui as nao herdadas, pelo authlogic

  resources :entidades#menu
  resources :emergencia#menu
  resources :noticia#menu
  resources :empresas#menu
  resources :voluntarios#dentro de usuario
  resources :doacaos#menu
  resources :newsletters#nao definido
  match "sobre" => "sobre#index"

end
