class CreateEmergencia < ActiveRecord::Migration
  def self.up
    create_table :emergencia do |t|
      t.string :nome,        :limit => 255
      t.text :desc
      t.date :data
      t.string :status,       :limite => 20
      t.boolean :validacao
      t.integer :entidade_id

      t.timestamps
    end
  end

  def self.down
    drop_table :emergencia
  end
end
