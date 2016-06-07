class CreateNewHighs < ActiveRecord::Migration
  def change
    create_table :new_highs do |t|
      t.string :symbol, null: false
      t.datetime :saved_on, null: false

      t.timestamps null: false
    end
    add_index :new_highs, [:symbol, :saved_on], unique: true
  end
end
