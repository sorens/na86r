class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :ptype
      t.integer :user_id
      t.integer :game_id
      t.integer :pipeline_id
      t.integer :score

      t.timestamps
    end
  end
end
