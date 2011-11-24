class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.string :guid
      t.integer :owner_id
      t.text :data
      t.integer :state

      t.timestamps
    end
  end
end
