class UserSession < Authlogic::Session::Base
  logout_on_timeout true # default if false
  # desloga automatico, quando o tempo acaba.
#  logout_on_timeout true if ENV['RAILS_ENV'] == 'development'

  # metodo adicionado na versao 3 do rails, para que a gem acl9 funcione.
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end