require_relative '../lib/barchart_all_time_high'

@all_time_highs = Barchart::AllTimeHigh.new
url = 'http://www.barchart.com/stocks/athigh.php'
html_tag = 'input'
page = @all_time_highs.pager(url)
html_tagging = @all_time_highs.html_tagging(page)
tickers = @all_time_highs.extract_tickers(html_tagging)
@all_time_highs.insert_all_time_highs(tickers)
