class Entidade < ActiveRecord::Base
  belongs_to :causa
  belongs_to :user

  has_many :emergencium, :dependent => :destroy
  has_many :noticium, :dependent => :destroy
  has_many :doacao

  #tem muitos telefones atraves do nested
  has_many :telefones, :dependent => :destroy
  accepts_nested_attributes_for :telefones, :reject_if => lambda { |a| a[:numero].blank? }, :allow_destroy => true

  #tem muitas contas atraves do nested
  has_many :conta, :dependent => :destroy
  accepts_nested_attributes_for :conta, :reject_if => lambda { |a| a[:nome || :numero].blank? }, :allow_destroy => true

  # Campos obrigatorios
  # Campos da entidade
  validates :nomefantasia, :razaosocial, :cnpj, :areaatuacao, :datafunda, :causa_id,
    :cep, :endereco, :numero, :cidade, :estado, :nome, :cpf, :presence => true

  validates :cnpj, :uniqueness => true

  usar_como_cnpj :cnpj
  usar_como_cpf :cpf
  
end