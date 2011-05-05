class CreateVoluntarios < ActiveRecord::Migration
  def self.up
    create_table :voluntarios do |t|
      t.string :nome,           :limit => 70
      t.string :apelido,        :limit => 30
      t.date   :datanasc
      t.string :cpf,            :limit => 13
      t.string :sexo,           :limit => 1

      t.string :profissao,      :limit => 70
      
      t.string :cep,            :limit => 10
      t.string :endereco,       :limit => 70
      t.string :numero,         :limit => 10
      t.string :complemento,    :limit => 70
      t.string :bairro,         :limit => 70
      t.string :cidade,         :limit => 40
      t.string :estado,         :limit => 2

      t.boolean :newsletter
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :voluntarios
  end
end
