class Emergencium < ActiveRecord::Base
  belongs_to :entidade
  
  # Campos obrigatorios
  validates :nome, :desc, :data, :presence => true

#  def self.dono?
#    logger.info "\n\n=> meleca entidade id: #{current_user.id}\n"
#    @entidade = Entidade.where(" user_id = ?", current_user.id) rescue nil
##    logger.info "\n\n=> meleca entidade id: #{@entidade[0].id}\n"
#    @emergencium = Emergencium.where(" entidade_id = ?", @entidade[0].id ) rescue nil
##    logger.info "\n\n=> meleca emergencium: #{@emergencium}\n"
#
#    if @emergencium.nil? or @emergencium.empty?
#      return false
#    else
#      return true
#    end
#  end
end
