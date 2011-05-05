class CreateTelefones < ActiveRecord::Migration
  def self.up
    create_table :telefones do |t|
      t.string :ddd, :limit => 2
      t.string :numero, :limit => 9
      t.string :tipo, :limit => 15
      t.integer :entidade_id
      t.integer :empresa_id
      t.integer :voluntario_id

      t.timestamps
    end
  end

  def self.down
    drop_table :telefones
  end
end
