class CreateAllTimeHighs < ActiveRecord::Migration
  def change
    create_table :all_time_highs do |t|
      t.string :symbol, null: false
      t.datetime :saved_on, null: false

      t.timestamps null: false
    end
    add_index :all_time_highs, [:symbol, :saved_on], unique: true
  end
end
