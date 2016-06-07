require 'mechanize'

module Barchart
  class NewHigh
    def initialize
      @mechanize = Mechanize.new
      @mechanize.user_agent = 'Mac Safari'
    end

    def pager(url, html_tag)
      @mechanize.get(url).search(html_tag)
    end

    def extract_tickers(page)
      total_symbols = page[6].to_s.scan(/[A-Z]+,[^a-z]+[A-Z]/)
      tickers = total_symbols[0].split(',')
    end

    def insert_new_highs(tickers)
      tickers.each { |t| ::NewHigh.create!(symbol: t, saved_on: Time.now) }
    end
  end
end
