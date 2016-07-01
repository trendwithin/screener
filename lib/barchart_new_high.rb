require 'mechanize'

module Barchart
  class NewHigh
    def initialize
      @mechanize = Mechanize.new
      @mechanize.user_agent = 'Mac Safari'
    end

    def paging(url, tries: 3)
      @mechanize.get(url)
      rescue => e
        Rails::logger.error "There was an Error Processing New Highs Download: #{e}"
        tries -= 1
        if tries > 0
          retry
        else
          raise e
        end
    end

    def html_tagging(html_tag)
      @mechanize.page.search(html_tag)
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
