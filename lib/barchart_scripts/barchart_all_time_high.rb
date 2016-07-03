require_relative 'barchart_suite'

module Barchart
  class AllTimeHigh < BarchartSuite

    def extract_tickers(page)
      total_symbols = page[6].to_s.scan(/[A-Z]+,[^a-z]+[A-Z]/)
      tickers = total_symbols[0].split(',')
    end

    def insert_all_time_highs(tickers)
      byebug
      tickers.each { |t| ::AllTimeHigh.create!(symbol: t, saved_on: Time.now) }
    end
  end
end
