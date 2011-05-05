class Doatipo < ActiveRecord::Base
  has_one :doacao

  #campos com validação obrigatoria
  validates :nome, :presence => true
end