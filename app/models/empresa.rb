class Empresa < ActiveRecord::Base

  #Itens por página (will_paginate)
  cattr_reader :per_page
  @@per_page = 10

  belongs_to :user
  has_many :doacao

  #tem muitos telefones atraves do nested
  has_many :telefones, :dependent => :destroy
  accepts_nested_attributes_for :telefones, :reject_if => lambda { |a| a[:numero].blank? || a[:tipo].blank? }, :allow_destroy => true

  # Campos obrigatorios
  # Campos da empresa
  validates :nomefantasia, :razaosocial, :cnpj, :areaatuacao, 
    :cep, :endereco, :numero, :cidade, :estado, :nome, :cpf, :presence => true

  validates :cnpj, :uniqueness => true
  
  usar_como_cnpj :cnpj
  usar_como_cpf :cpf
end