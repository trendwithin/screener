class CreateDailyHighLows < ActiveRecord::Migration
  def change
    create_table :daily_high_lows do |t|
      t.integer :one_month_high, null: false
      t.integer :one_month_low, null: false
      t.integer :three_month_high, null: false
      t.integer :three_month_low, null: false
      t.integer :six_month_high, null: false
      t.integer :six_month_low, null: false
      t.integer :twelve_month_high, null: false
      t.integer :twelve_month_low, null: false
      t.integer :ytd_high, null: false
      t.integer :ytd_low, null: false
      t.datetime :saved_on, null: false

      t.timestamps null: false
    end
    add_index :daily_high_lows, :saved_on, unique: true
  end
end
