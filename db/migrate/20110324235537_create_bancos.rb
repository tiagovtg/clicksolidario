class CreateBancos < ActiveRecord::Migration
  def self.up
    create_table :bancos do |t|
      t.string :nome, :limit => 30
      t.timestamps
    end
    # Bancos pre cadastrados
    Banco.create :nome => 'Brasil'
    Banco.create :nome => 'Caixa Economica'
    Banco.create :nome => 'Itau'
    Banco.create :nome => 'Bradesco'
  end

  def self.down
    drop_table :bancos
  end
end
