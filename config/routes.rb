Sgss::Application.routes.draw do
  #todas rotas necessarias para rodar o authlogic
  root :to => "portal#index"

  resources :users
  match "join" => "users#new"
  match "activate_deactivate" => "users#activate_deactivate"

  resource :account, :controller => "users"

  resource :user_session
  match "login" => "user_sessions#new"
  match "logout" => "user_sessions#destroy"

  #aqui as nao herdadas, pelo authlogic
  #
  #portal
  match "busca_entidade" => "portal#busca_entidade"
  match "busca_perfil"  => "portal#busca_perfil"
  match "ajude"         => "ajude#index"
  match "conheca"       => "conheca#index"
  match "contato"       => "contato#index"
  match "duvida"        => "duvida#index"

  #sgs
  resources :entidades#menu
  resources :emergencia#menu
  resources :noticia#menu
  resources :empresas#menu
  resources :voluntarios#dentro de usuario
  resources :doacaos#menu
  resources :newsletters#nao definido
  match "sobre" => "sobre#index"
end
