require_relative 'barchart_new_high'

@new_highs = Barchart::NewHigh.new
url = 'http://www.barchart.com/stocks/high.php'
html_tag = 'input'
page = @new_highs.paging(url, html_tag)
tickers = @new_highs.extract_tickers(page)
@new_highs.insert_new_highs(tickers)
