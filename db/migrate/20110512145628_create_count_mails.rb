class CreateCountMails < ActiveRecord::Migration
  def self.up
    create_table :count_mails do |t|
      t.integer :enviados

      t.timestamps
    end
  end

  def self.down
    drop_table :count_mails
  end
end
