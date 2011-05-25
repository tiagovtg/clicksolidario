class Emergencium < ActiveRecord::Base

  #Itens por página (will_paginate)
  cattr_reader :per_page
  @@per_page = 2


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

  # Definições do Paperclip
  has_attached_file :imagem, :styles => { :thumb => "100x100>" }

  validates_attachment_content_type :imagem, :content_type => [ 'image/png', 'image/jpeg' ]
  validates_attachment_size :imagem, :less_than => 100.kilobytes
  validate :verifica_presenca_de_imagem

  private
  def verifica_presenca_de_imagem
    errors.add(:imagem, " não pode ficar em branco! Deve ser feito o upload de um arquivo de imagem") if
    imagem_file_name == nil
  end
end
