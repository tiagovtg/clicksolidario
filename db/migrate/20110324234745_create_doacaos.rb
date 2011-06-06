class CreateDoacaos < ActiveRecord::Migration
  def self.up
    create_table :doacaos do |t|
      t.decimal :valor, :precision => 9, :scale => 2
      t.date    :data
      t.boolean :valida
      t.text    :obs
      t.integer :user_id
      t.integer :entidade_id
      t.integer :doatipo_id

      t.timestamps
    end
  end

  def self.down
    drop_table :doacaos
  end
end
