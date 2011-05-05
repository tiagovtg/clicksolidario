class CreateConta < ActiveRecord::Migration
  def self.up
    create_table :conta do |t|
      t.string :nome,         :limit => 70
      t.string :numero,       :limit => 10
      t.string :operacao,     :limit => 10
      t.string :agencia,      :limit => 30
      t.integer :entidade_id
      t.integer :banco_id

      t.timestamps
    end
  end

  def self.down
    drop_table :conta
  end
end
