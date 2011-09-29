class CreateUnits < ActiveRecord::Migration
  def change
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
