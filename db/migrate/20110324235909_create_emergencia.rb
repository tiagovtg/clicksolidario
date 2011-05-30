class CreateEmergencia < ActiveRecord::Migration
  def self.up
    create_table :emergencia do |t|
      t.string :titulo,        :limit => 255
      t.string :resumo,        :limit => 255
      t.text :emergencia
      t.date :data
      t.string :status,       :limite => 20

      t.string :imagem_file_name,             :null => false
      t.string :imagem_content_type,          :null => false
      t.integer :imagem_file_size,            :null => false
      t.datetime :imagem_updated_at,          :null => false
      
      t.boolean :validacao
      t.integer :entidade_id

      t.timestamps
    end
  end

  def self.down
    drop_table :emergencia
  end
end
