class Telefone < ActiveRecord::Base
  belongs_to :voluntario
  belongs_to :entidade
  belongs_to :empresa

  # validações de campos
  validates :ddd, :numero, :tipo, :presence => true
end