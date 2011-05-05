class CreateCausas < ActiveRecord::Migration
  def self.up
    create_table :causas do |t|
      t.string :nome,     :limit => 20

      t.timestamps
    end
    # Causas pre cadastrados
    Causa.create :nome => 'Saúde'
    Causa.create :nome => 'Educação'
    Causa.create :nome => 'Ambiental'
    Causa.create :nome => 'Arte & Cultura'
    Causa.create :nome => 'Social'
  end

  def self.down
    drop_table :causas
  end
end