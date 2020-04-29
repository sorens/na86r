class AddPlayerIdToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :player_id, :integer
    remove_column :groups, :user_id
  end
  
  def self.down
    remove_column :groups, :player_id
    add_column :groups, :user_id, :integer
  end
end
