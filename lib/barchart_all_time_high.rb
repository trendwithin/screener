require 'mechanize'

module Barchart
  class AllTimeHigh
    def initialize
      @mechanize = Mechanize.new
      @mechanize.user_agent = 'Mac Safari'
    end

    def pager(url, html_tag)
      @mechanize.get(url).search(html_tag)
    end

    def insert_all_time_highs(tickers)
      tickers.each { |t| ::AllTimeHigh.create!(symbol: t, saved_on: Time.now) }
    end
  end
end
