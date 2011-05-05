class CreateDoatipos < ActiveRecord::Migration
  def self.up
    create_table :doatipos do |t|
      t.string :nome, :limit => 70
      
      t.timestamps
    end
    # Tipos doações pre cadastrados
    Doatipo.create :nome => 'Voluntario'
    Doatipo.create :nome => 'Sangue'
    Doatipo.create :nome => 'Donativos'
    Doatipo.create :nome => 'Bens'
  end

  def self.down
    drop_table :doatipos
  end
end
