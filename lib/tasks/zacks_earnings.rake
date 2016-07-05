require 'csv'

namespace :import_zacks do
  desc 'Import Zacks Earnings Data from CSV'
  task earnings: :environment do
    filename = File.join Rails.root, 'db/seed_data/zacks_earnings.csv'

    CSV.foreach(filename) do |row|
      Zack.create(
      symbol: row[0],
      company: row[1],
      report_time: row[2],
      estimate: row[3],
      reported: row[4],
      surprise: row[5],
      current_price: row[6],
      price_pct_change: row[7]
      )
    end
  end
end
