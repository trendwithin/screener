class CreateZacks < ActiveRecord::Migration
  def change
    create_table :zacks do |t|
      t.string :symbol, null: false
      t.string :company
      t.string :report_time
      t.string :estimate, null: false
      t.string :reported, null: false
      t.string :surprise
      t.string :current_price
      t.string :price_pct_change

      t.timestamps null: false
    end
    add_index :zacks, [:symbol]
  end
end
