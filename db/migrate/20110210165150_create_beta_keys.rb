class CreateBetaKeys < ActiveRecord::Migration
  def self.up
    create_table :beta_keys do |t|
      t.string :key
      t.integer :active
      t.datetime :activated_at
      t.string :assigned_to

      t.timestamps
    end
  end

  def self.down
    drop_table :beta_keys
  end
end
