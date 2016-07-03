require_relative 'barchart_all_time_high'

@all_time_highs = Barchart::AllTimeHigh.new
url = 'http://www.barchart.com/stocks/athigh.php'
html_tag = 'input'
page = @all_time_highs.paging(url, html_tag)
tickers = @all_time_highs.extract_tickers(page)
@all_time_highs.insert_all_time_highs(tickers)
