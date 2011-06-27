# encoding: UTF-8
class Emergencium < ActiveRecord::Base

  #Itens por página (will_paginate)
  cattr_reader :per_page
  @@per_page = 10


  belongs_to :entidade
  
  # Campos obrigatorios
  validates :titulo, :resumo, :emergencia, :data, :presence => true

  # Definições do Paperclip
  has_attached_file :imagem, :styles => { :thumb => "100x100>" }

  # configurações para upload de imagem
  validates_attachment_content_type :imagem, :content_type => [ 'image/png', 'image/jpeg' ]
  validates_attachment_size :imagem, :less_than => 100.kilobytes
  validate :verifica_presenca_de_imagem

  private
  def verifica_presenca_de_imagem
    errors.add(:imagem, " não pode ficar em branco! Deve ser feito o upload de um arquivo de imagem") if
    imagem_file_name == nil
  end
end
