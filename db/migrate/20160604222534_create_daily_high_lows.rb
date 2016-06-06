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
      t.datetime :saved_on, null: false, unique:true

      t.timestamps null: false
    end
  end
end
