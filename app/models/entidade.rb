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
  def self.busca_solidaria(query, uf, causa)
    q=false
    u=false
    c=false
    if query.nil? or query.empty? or query=="Digite aqui o nome da entidade..."
      query=""
    else
      query=" entidades.nome LIKE"+" '%#{query}%' "
      q=true
    end

    if uf.nil? or uf.empty? or uf==""
      uf=""
    else
      uf=" entidades.estado LIKE"+ " '%#{uf}%' "
      u=true
    end

    if causa.nil? or causa.empty? or causa==""
      causa=""
    else
      causa=" entidades.causa_id = #{causa} "
      c=true
    end

    if q and u
      query << ' and '
    end
    if q and c and !u
      query << ' and '
    end
    if u and c
      uf << ' and '
    end

    a = query << uf << causa
    
    #    paginate(:page => 10,  :order => 'cnpj')
    #:conditions => ["#{a}"],
    where(a).order('cnpj').limit(10)
  end
  
end