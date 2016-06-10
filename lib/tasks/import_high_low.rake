require 'csv'

namespace :import do
  desc "Import BarchartHighLow Data from CSV"
  task newhighlows: :environment do
    filename = File.join Rails.root, 'db/seed_data/newhilow.csv'

    CSV.foreach(filename) do |row|
      DailyHighLow.create!(
        saved_on: row[0],
        one_month_high: row[1],
        one_month_low: row[2],
        three_month_high: row[3],
        three_month_low: row[4],
        six_month_high: row[5],
        six_month_low: row[6],
        twelve_month_high: row[7],
        twelve_month_low: row[8],
        ytd_high: row[9],
        ytd_low: row[10]
      )
    end
  end
end
