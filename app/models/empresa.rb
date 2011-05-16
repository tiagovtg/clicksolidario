class Empresa < ActiveRecord::Base
  belongs_to :user
  has_many :doacao

  #tem muitos telefones atraves do nested
  has_many :telefones, :dependent => :destroy
  accepts_nested_attributes_for :telefones, :reject_if => lambda { |a| a[:numero].blank? }, :allow_destroy => true

  # Campos obrigatorios
  # Campos da empresa
  validates :nomefantasia, :razaosocial, :cnpj, :areaatuacao, 
    :cep, :endereco, :numero, :cidade, :estado, :nome, :cpf, :presence => true

  validates :cnpj, :uniqueness => true
  
  usar_como_cnpj :cnpj
#  usar_como_cpf :cpf
end