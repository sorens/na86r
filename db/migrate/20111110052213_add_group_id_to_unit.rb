class AddGroupIdToUnit < ActiveRecord::Migration
  def self.up
    add_column :units, :group_id, :integer
    remove_column :units, :user_id
  end
  
  def self.down
    add_column :units, :user_id, :integer
    remove_column :units, :group_id
  end
end
