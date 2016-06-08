require 'mechanize'
require 'date'

module Briefings
  class Earnings
    def initialize
      @mechanize = Mechanize.new
      @mechanize.user_agent = 'Mac Safari'
    end

    def pager(url, html_tag)
      @mechanize.get(url).search(html_tag)
    end

    def todays_date_conversion
      month = Date::MONTHNAMES[Date.today.month]
      day = Date.today.day
      day = "0#{day}" if day < 10
      "#{month} #{day}"
    end

    def parse_current_date_data(page)
      Rails.env.test? ? todays_date = 'June 02' : todays_date = todays_date_conversion
      found_node = nil
      page.each do |node|
        node = node.to_s
        if node.include?(todays_date.to_s)
          found_node = node
          break
        end
      end
      found_node
    end
  end
end
