class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :guid
      t.integer :time
      t.integer :scenario_id
      t.integer :state
      t.text :setup
      t.text :data

      t.timestamps
    end
  end
end
