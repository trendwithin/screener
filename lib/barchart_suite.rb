require 'mechanize'

class BarchartSuite
  attr_accessor :mechanize

  def initialize
    @mechanize = Mechanize.new
    @mechanize.user_agent = 'Mac Safari'
  end

  def paging(url, html_tag)
    @mechanize.get(url).search(html_tag)
  end
end
