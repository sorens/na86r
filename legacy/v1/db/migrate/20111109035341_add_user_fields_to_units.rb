class AddUserFieldsToUnits < ActiveRecord::Migration
  def self.up
    add_column  :units, :user_id, :integer
  end
  
  def self.down
    remove_column :units, :user_id
  end
end
