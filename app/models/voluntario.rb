class Voluntario < ActiveRecord::Base
  belongs_to :user

  has_many :doacao

  #tem muitos telefones atraves do nested
  has_many :telefones, :dependent => :destroy
  accepts_nested_attributes_for :telefones, :reject_if => lambda { |a| a[:numero].blank? || a[:tipo].blank? }, :allow_destroy => true

  #Campos obrigatorios
  validates :nome, :cpf, :profissao, :datanasc, :sexo, 
    :cep, :endereco, :numero, :cidade, :estado, :presence => true

  validates :cpf, :uniqueness => true

  #Valida como cpf
  usar_como_cpf :cpf
  
end