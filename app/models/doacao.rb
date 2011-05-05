class Doacao < ActiveRecord::Base
  belongs_to :voluntario
  belongs_to :empresa
  belongs_to :entidade
  belongs_to :doatipo

  #campos com validação obrigatoria
  validates :data, :presence => true
end
