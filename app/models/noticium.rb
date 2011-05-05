class Noticium < ActiveRecord::Base
  belongs_to :entidade

  #campos com validação obrigatoria
  validates :nome, :texto, :data, :presence => true
end
