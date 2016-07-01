require 'mechanize'
require 'date'

module Briefings
  class Earnings
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

    def todays_date_conversion
      month = Date::MONTHNAMES[Date.today.month]
      day = Date.today.day
      day = "0#{day}" if day < 10
      "#{month} #{day}"
    end

    def parse_current_date_data(page)
      todays_date = todays_date_conversion
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

    def insert_briefings_data(data)
      raise 'Parsed Briefing Dom Returned Empty' if data.blank?
      data.each do |elem|
        BriefingsEarning.create!(symbol: elem[2], earnings: elem[3], expectation: elem[5],
                         year_ago_earnings: elem[6], revenue: elem[8],
                         saved_on: Time.now ) if self.valid?(elem)
      end
    end

    def valid?(elem)
      true unless elem[3].blank? || elem[3].empty?
    end
  end
end
