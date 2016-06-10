require 'csv'

namespace :newhighs do
  desc 'Import All Time High Data from CSV'
  task insert: :environment do
    filename = File.join Rails.root, 'db/seed_data/new_highs.csv'

    CSV.foreach(filename) do |row|
      NewHigh.create!(
      symbol: row[0],
      saved_on: row[1]
      )
    end
  end
end
