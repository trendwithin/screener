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
        find_todays_data = node.to_s
        if find_todays_data.include?(todays_date.to_s)
          found_node = node
          break
        end
      end
      found_node
    end

    def parse_selector(data)
      rd = data.css('td').select { |row| row['class'] == 'rD' }
      ld = data.css('td').select { |row| row['class'] == 'LD' }
      rd.concat(ld)
    end

    def format_parsed_selector(data)
      data.map! { |item| item.text }
      data.map! { |item| item.split.join(' ') }
      data.each_slice(9).to_a
    end
  end
end
