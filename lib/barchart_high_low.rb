require 'mechanize'

module Barchart
  class HighLow
    def initialize
      @mechanize = Mechanize.new
      @mechanize.user_agent = 'Mac Safari'
    end

    def pager(url, html_tag)
      @mechanize.get("#{url}").search("#{html_tag}")
    end

    def one_month_high(page)
      data_point = page.search('*[@id="divContent"]/div[3]/table/tr[2]/td[2]/a').text
      data_conversion(data_point)
    end

    def one_month_low(page)
      data_point = page.search('*[@id="divContent"]/div[3]/table/tr[3]/td[2]/a').text
      data_conversion(data_point)
    end

    def data_conversion(data)
      data =~ /^\d+$/ ? data : '0'
    end
  end
end
