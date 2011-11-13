class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :gtype
      t.string :mission
      t.integer :user_id
      t.integer :sensor_state
      t.integer :location_x
      t.integer :location_y
      t.integer :condition
      t.integer :endurance

      t.timestamps
    end
  end
end
