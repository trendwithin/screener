require 'csv'

namespace :alltimehigh do
  desc 'Import All Time High Data from CSV'
  task insert: :environment do
    filename = File.join Rails.root, 'db/seed_data/all_time_highs.csv'

    CSV.foreach(filename) do |row|
      AllTimeHigh.create!(
      symbol: row[0],
      saved_on: row[1]
      )
    end
  end
end
