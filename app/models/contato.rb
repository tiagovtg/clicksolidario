class Contato < ActiveRecord::Base
  
  validates :nome, :assunto, :telefone, :mensagem, :presence => true

  validates_format_of :email, :with => Authlogic::Regex.email

  validates :telefone, :length => { :within => 13..13 }
  validates :mensagem, :length => { :within => 10..500 }

end
