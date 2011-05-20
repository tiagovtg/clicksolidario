class Entidade < ActiveRecord::Base

  #Itens por página (will_paginate)
  cattr_reader :per_page
  @@per_page = 10

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
  #  usar_como_cpf :cpf

  #Metodo de busca, Busca_solidaria
  def self.busca_solidaria(query, uf, causa, page)
    logger.info "\n\n=> meleca : #{query} \n"
    logger.info "\n\n=> meleca : #{uf} \n"
    logger.info "\n\n=> meleca : #{causa} \n"

    if query.nil? or query.empty? or query=="Digite aqui o nome da entidade..."
      query=nil
    end
    if uf.nil? or uf.empty? or uf==""
      uf=nil
    end
    if causa.nil? or causa.empty? or causa==""
      causa=nil
    end
    query1 = (query.nil? ? '' : "entidades.nome LIKE"+" '%#{query}%' ")
    uf1 = (uf.nil? ? '' : " entidades.estado LIKE"+ " '%#{uf}%' ")
    causa1= (causa.nil? ? '' : " entidades.causa_id == #{causa} ")

    a = query1 << (uf.nil? ? '' : ' and ' << uf1) << (causa == "" ? '' : ' and ' << causa1)
    logger.info "\n\n=> meleca : #{a} \n"
    paginate(:page => page, :order => 'cnpj', :conditions => [".", "#{a}"])
  end
  
end