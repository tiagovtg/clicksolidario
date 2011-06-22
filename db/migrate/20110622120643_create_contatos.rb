class CreateContatos < ActiveRecord::Migration
  def self.up
    create_table :contatos do |t|
      t.string :nome, :limit => 100
      t.string :email, :limit => 100
      t.string :assunto, :limit => 20
      t.string :telefone, :limit => 13
      t.text :mensagem

      t.timestamps
    end
  end

  def self.down
    drop_table :contatos
  end
end
