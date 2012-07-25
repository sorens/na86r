class Uuid < ActiveRecord::Migration
  def up
    rename_column :games, :guid, :uuid
    rename_column :scenarios, :guid, :uuid
    add_column    :users, :uuid, :string
  end

  def down
    rename_column :games, :uuid, :guid
    rename_column :scenarios, :uuid, :guid
    remove_column :users, :uuid
  end
end
