require 'mechanize'

module Barchart
  class HighLow
    def initialize
      @mechanize = Mechanize.new
      @mechanize.user_agent = 'Mac Safari'
    end

    def paging(url, tries: 3)
      @mechanize.get(url)
      rescue => e
        Rails::logger.error "There was an Error Processing New High Lows Download: #{e}"
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

    def extract_high_low(page, tr, td)
      data_point = page.search("*[@id='divContent']/div[3]/table/tr[#{tr}]/td[#{td}]/a").text
      data_conversion(data_point)
    end

    def data_conversion(data)
      data =~ /^\d+$/ ? data : '0'
    end

    def high_low_data_insertion(data_hash)
      ::DailyHighLow.create!(data_hash)
    end
  end
end
