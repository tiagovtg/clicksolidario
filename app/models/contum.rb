class Contum < ActiveRecord::Base
  belongs_to :entidade
  belongs_to :banco

  #Campos obrigatorios
  validates :nome, :numero, :agencia, :banco_id, :presence => true

end