class Newsletter < ActiveRecord::Base
  validates :nome, :email, :presence => true
  validates :email, :uniqueness => true

  #Itens por página (will_paginate)
  cattr_reader :per_page
  @@per_page = 10
end
