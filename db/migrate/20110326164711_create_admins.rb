# encoding: UTF-8
class CreateAdmins < ActiveRecord::Migration
  #classe para inclusao da administração do sistema

  def self.up
    #TODO especificar senha padrão para administrador
    # inclui um usuario admininistrador
    #       @user = User.new
    #    @user.id = 1
    #    @user.login = "admin"
    #    @user.email = "admin@admin.com"
    #    @user.crypted_password = "d5da8ae181962dbc02da9308157c396e60e5c15573ab75c7458ef99e1944823420961f63d6d8b24c9eda7477b2d97fb96140e3914ab53e914f749623b5299117"
    #    @user.password_salt = "aKayLPR6aXEN3HQfqQF"
    #    @user.persistence_token = "c18c1de546069ba433d986bad0ead6aa2526a60d3f689000ab0281506d973039aea47925795cfec4b00ae782174aae16e6c01c2ea853e04b441321b6bcee7f2d"
    #    @user.single_access_token = "aKayLPR6aXEN3HQfqQF"
    #    @user.perishable_token = "mXcJ3HHpeJ8LAZ5jsLoU"
    #    @user.failed_login_count = 0
    #    @user.last_request_at = ""
    #    @user.current_login_ip = "127.0.0.1"
    #    @user.status = "Ativo"
       
    #
    #    @role = Role.new
    #    @role.id = 1
    #    @role.name = "administrador"
    #    @role.authorizable_type = nil
    #    @role.authorizable_id = nil
    #
    #
    ##    Transação com Rollback aninhado
    #    ActiveRecord::Base.transaction do
    #      begin
    #        @user.save
    #        @role.save
    #      rescue
    #        raise ActiveRecord::Rollback
    #      end
    #    end
    
    #        @role_user = roles_users.new
    #        @role_user.user_id = 1
    #        @role_user.role_id = 1
    #        @role_user.save



    #    execute " INSERT INTO users (id, email, crypted_password, password_salt, persistence_token, single_access_token, perishable_token, failed_login_count, last_request_at, current_login_ip, status, nome, created_at, updated_at) VALUES
    #    (1, 'admin@admin.com', 'd5da8ae181962dbc02da9308157c396e60e5c15573ab75c7458ef99e1944823420961f63d6d8b24c9eda7477b2d97fb96140e3914ab53e914f749623b5299117', '0jiuJcXPwgA2j1L0IPDk', 'c18c1de546069ba433d986bad0ead6aa2526a60d3f689000ab0281506d973039aea47925795cfec4b00ae782174aae16e6c01c2ea853e04b441321b6bcee7f2d', 'aKayLPR6aXEN3HQfqQF', 'mXcJ3HHpeJ8LAZ5jsLoU', 0, '', '127.0.0.1', 'Ativo','Admin', '2011-03-07 15:50:36', '')"
    #
    #    execute " INSERT INTO roles (id, name, authorizable_type, authorizable_id, created_at, updated_at) VALUES
    #    (1, 'administrador', NULL, NULL, '2010-10-27 14:51:23', '') "
    #
    #    execute " INSERT INTO roles_users (user_id, role_id, created_at, updated_at ) VALUES
    #    (1, 1, '2010-10-27 14:51:23', null)"

    execute " INSERT INTO users (email, crypted_password, password_salt, persistence_token, single_access_token, perishable_token, failed_login_count, current_login_ip, status, nome) VALUES
                    ('admin@admin.com', 'd5da8ae181962dbc02da9308157c396e60e5c15573ab75c7458ef99e1944823420961f63d6d8b24c9eda7477b2d97fb96140e3914ab53e914f749623b5299117', '0jiuJcXPwgA2j1L0IPDk', 'c18c1de546069ba433d986bad0ead6aa2526a60d3f689000ab0281506d973039aea47925795cfec4b00ae782174aae16e6c01c2ea853e04b441321b6bcee7f2d', 'aKayLPR6aXEN3HQfqQF', 'mXcJ3HHpeJ8LAZ5jsLoU', 0, '127.0.0.1', 'Ativo','Admin')"

    execute " INSERT INTO roles_users (user_id, role_id, created_at, updated_at ) VALUES
               (1, 1, '2010-10-27 14:51:23', null)"

    # cria as regras de configuraçoes padroes da aplicação
    #    conf = Configuracoe.new
    #    conf.nome = "paginacao"
    #    conf.valor = "10"
    #    conf.tipo = "integer"
    #    conf.save
  end

  def self.down
    # O metodo down, elimina o unico usuario que deveria existir nesse ponto, o administrador.
    @user = User.all
    @user.destroy
    
    @role =  Role.all
    @role.destroy
    
    #    @role_user = Role_User.all
    #    @role_user.destroy

    execute "DELETE * from roles_users where user_id = 1"

    #    conf = Configuracoe.find_by_nome(:nome => 'paginacao')
    #    conf.destroy
  end
end
