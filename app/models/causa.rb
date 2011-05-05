class Causa < ActiveRecord::Base
  #causa tem muitas instituições atraves da associativa
  has_one :entidade
end