class CreateEmpresas < ActiveRecord::Migration
  def self.up
    create_table :empresas do |t|
      t.string :nomefantasia,     :limit => 100
      t.string :razaosocial,      :limit => 200
      t.string :cnpj,             :limit => 18
      t.string :ramoatividade,    :limit => 100
      t.string :areaatuacao,      :limit => 70
      t.string :site,             :limit => 100

      t.string :nome,           :limit => 70
      t.string :apelido,        :limit => 30
      t.date   :datanasc
      t.string :cpf,            :limit => 14
      t.string :sexo,           :limit => 9

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
    drop_table :empresas
  end
end
