class CreateNewsletters < ActiveRecord::Migration
  def self.up
    create_table :newsletters do |t|
      t.string :nome,  :limit => 70
      t.string :email, :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :newsletters
  end
end
