require_relative 'fetch_briefings'

@briefings = Briefings::Earnings.new
url = 'http://hosting.briefing.com/cschwab/Calendars/EarningsCalendar5Weeks.htm'
html_tag = ".//table[@width='100%']"
html_tagging = @briefings.paging(url, html_tag)
node = @briefings.parse_current_date_data(html_tagging)
parse = @briefings.parse_selector(node)
parsed_data = @briefings.format_parsed_selector(parse)
@briefings.insert_briefings_data(parsed_data)
