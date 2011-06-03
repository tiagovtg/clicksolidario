class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email,                :null => false, :limit => 70
      t.string :crypted_password,     :null => false
      t.string :password_salt,        :null => false
      t.string :persistence_token,    :null => false
      t.string :single_access_token,  :null => false
      t.string :perishable_token,     :null => false
      t.integer :failed_login_count,  :null => false, :default => 0
      t.datetime :last_request_at
      t.string :current_login_ip,                     :limit => 30
      t.string :status,               :null => false, :limit => 10
      t.string :nome,                                 :limit => 100
      t.boolean :newsletter

      t.timestamps
    end
#    user = User.create do |u|
#      u.id = 1
#      u.name = 'Administrador'
#      u.login = 'admin'
#      u.password = u.password_confirmation = 'admin'
#      u.email = 'admin@domain.com'
#      u.type = 'Admin'
#    end

    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
