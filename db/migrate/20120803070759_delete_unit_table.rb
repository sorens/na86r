class DeleteUnitTable < ActiveRecord::Migration
  def up
  	drop_table :units
  end

  def down
    create_table :units do |t|
      t.string :guid
      t.string :name
      t.string :uclass
      t.string :maker
      t.string :number
      t.string :utype
      t.integer :version
      t.text :data

      t.timestamps
  	end
  end
end
