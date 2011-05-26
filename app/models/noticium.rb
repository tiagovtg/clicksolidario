class Noticium < ActiveRecord::Base
#  self.order('validacao Desc')

  #Itens por página (will_paginate)
  cattr_reader :per_page
  @@per_page = 10
  
  belongs_to :entidade

  #campos com validação obrigatoria
  validates :nome, :texto, :data, :presence => true
end
