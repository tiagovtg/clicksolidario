# encoding: UTF-8
class Emergencium < ActiveRecord::Base

  #Itens por página (will_paginate)
  cattr_reader :per_page
  @@per_page = 10


  belongs_to :entidade
  
  # Campos obrigatorios
  validates :titulo, :resumo, :emergencia, :data, :presence => true

  # Definições do Paperclip, abaixo endereço para pegar a key
  #  https://aws-portal.amazon.com/gp/aws/developer/account/index.html?ie=UTF8&action=access-key#access_credentials
  if ENV['RAILS_ENV'] == 'production'
    has_attached_file :imagem, :styles => { :thumb => "100x100>" },
      :storage => :s3,
      :bucket => 'clicksolidariobucket',
      :s3_credentials => {
      :access_key_id => 'AKIAJYQADWXR2BXWKGXQ',
      :secret_access_key => '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'
    }
  else
    has_attached_file :imagem, :styles => { :thumb => "100x100>" }
  end


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