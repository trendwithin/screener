require_relative '../lib/fetch_briefings'
require 'byebug'
@briefings = Briefings::Earnings.new
url = 'http://hosting.briefing.com/cschwab/Calendars/EarningsCalendar5Weeks.htm'
html_tag = ".//table[@width='100%']"
@briefings.paging(url)
html_tagging = @briefings.html_tagging(html_tag)
node = @briefings.parse_current_date_data(html_tagging)
parse = @briefings.parse_selector(node)
parsed_data = @briefings.format_parsed_selector(parse)
@briefings.insert_briefings_data(parsed_data)
