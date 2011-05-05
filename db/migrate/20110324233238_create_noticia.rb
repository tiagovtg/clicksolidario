class CreateNoticia < ActiveRecord::Migration
  def self.up
    create_table :noticia do |t|
      t.string :nome,  :limit => 15
      t.string :texto, :limit => 100
      t.date :data
      t.boolean :validacao
      t.integer :entidade_id

      t.timestamps
    end
  end

  def self.down
    drop_table :noticia
  end
end
