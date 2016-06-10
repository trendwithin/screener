require 'csv'

namespace :import_briefings do
  desc "Import Briefings Earnings Data from CSV"
  task earnings: :environment do
    filename = File.join Rails.root, 'db/seed_data/briefings_earnings.csv'

    CSV.foreach(filename) do |row|
      BriefingsEarning.create(
      symbol: row[0],
      saved_on: row[1],
      earnings: row[3],
      expectation: row[4],
      year_ago_earnings: row[5],
      revenue: row[6]
      )
    end
  end
end
