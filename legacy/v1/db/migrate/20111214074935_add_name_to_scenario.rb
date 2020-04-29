class AddNameToScenario < ActiveRecord::Migration
  def self.up
    add_column :scenarios, :name, :string
  end
  
  def self.down
    remove_column :scenarios, :name
  end
end
