class RemovePipelineIdFromGroups < ActiveRecord::Migration
  def self.up
    remove_column :players, :pipeline_id
  end
  
  def self.down
    add_column :players, :pipeline_id, :integer
  end
end
