class User < ActiveRecord::Base
  #OBS: a gem AuthLogic ja faz todas as validações necessarias para a modelo User

  #Itens por página (will_paginate)
  cattr_reader :per_page
  @@per_page = 2

  #  Tempo para deslogar automaticamente nos ambientes abaixo.
  acts_as_authentic do |c|
    c.logged_in_timeout = 10.minutes if ENV['RAILS_ENV'] == 'development'
    #Requisito, sessao expira em 10 minutos
    c.logged_in_timeout = 10.minutes if ENV['RAILS_ENV'] == 'production'
  end

  acts_as_authorization_subject
  #  acts_as_authorization_subject  :association_name => :roles

  # valida o tamanho do nome
  validates_length_of :nome, :within => 5..70

  #Retorna o nome do tipo de perfil do ator
  def administrador?
    self.has_role?(:administrador)
  end
  def voluntario?
    self.has_role?(:voluntario)
  end

  def entidade?
    self.has_role?(:entidade)
  end

  def empresa?
    self.has_role?(:empresa)
  end

end
