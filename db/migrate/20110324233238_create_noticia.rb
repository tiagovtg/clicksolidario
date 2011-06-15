class CreateNoticia < ActiveRecord::Migration
  def self.up
    create_table :noticia do |t|
      t.string :titulo,        :limit => 90
      t.string :resumo,        :limit => 180
      t.text :noticia
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
