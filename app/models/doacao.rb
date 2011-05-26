class Doacao < ActiveRecord::Base

  #Itens por página (will_paginate)
  cattr_reader :per_page
  @@per_page = 10
  
  belongs_to :voluntario
  belongs_to :empresa
  belongs_to :entidade
  belongs_to :doatipo

  #campos com validação obrigatoria
  validates :data, :presence => true
end
