Sgss::Application.routes.draw do
  # rota principal
  root :to => "portal#index"

  #todas rotas necessarias para rodar o authlogic
  resources :users
  match "join" => "users#new"
  match "activate_deactivate" => "users#activate_deactivate"

  resource :account, :controller => "users"

  resource :user_session
  match "login" => "user_sessions#new"
  match "logout" => "user_sessions#destroy"

  #portal
  match "busca_solidaria"   => "portal#busca_solidaria"

  #menu principal
  match "ajude"             => "ajude#index"
  match "conheca"           => "conheca#index"
  match "duvida"            => "duvida#index"
  match "contato"           => "contato#index"

  #menu esquerdo
  match "quemsomos"        => "quemsomos#index"
  match "apoiadores"        => "apoiadores#index"
  match "divulgue"          => "divulgue#index"
  match "publicidade"       => "publicidade#index"
  match "imprensa"          => "imprensa#index"
  
  #saiba como
  match "adotar"            => "adotar#index"
  match "conviver"          => "conviver#index"
  match "reciclar"          => "reciclar#index"
  match "empresacidada"     => "empresacidada#index"
  match "doadororgaos"      => "doadororgaos#index"
  
  #
  match "veja_como"         => "vejacomo#index"

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
