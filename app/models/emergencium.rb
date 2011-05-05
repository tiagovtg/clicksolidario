class Emergencium < ActiveRecord::Base
  belongs_to :entidade
  
  # Campos obrigatorios
  validates :nome, :desc, :data, :presence => true

  def self.dono?
    if @entidade = Entidade.where(" user_id = ?", current_user.id) rescue nil
      return true
    else
      return false
    end

    #      @entidade.user == current_user
    #  end
  end
end
