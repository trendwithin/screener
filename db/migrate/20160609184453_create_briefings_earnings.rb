class CreateBriefingsEarnings < ActiveRecord::Migration
  def change
    create_table :briefings_earnings do |t|
      t.string :symbol, null: false
      t.float :earnings, null: false
      t.float :expectation
      t.float :year_ago_earnings
      t.string :revenue
      t.datetime :saved_on, null: false

      t.timestamps null: false
    end
    add_index :briefings_earnings, [:symbol, :saved_on], unique: true
  end
end
