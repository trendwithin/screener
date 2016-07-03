require_relative 'barchart_high_low'

@new_high_lows = Barchart::HighLow.new
url = 'http://www.barchart.com/stocks/newhilo.php?dwm=d'
html_tag = "div[id='divContent']"
hash = Hash.new(0)
page = @new_high_lows.paging(url, html_tag)

hash[:one_month_high] = @new_high_lows.extract_high_low(page, 2, 2)
hash[:one_month_low] = @new_high_lows.extract_high_low(page, 3, 2)
hash[:three_month_high] = @new_high_lows.extract_high_low(page, 4, 2)
hash[:three_month_low] = @new_high_lows.extract_high_low(page, 5, 2)
hash[:six_month_high] = @new_high_lows.extract_high_low(page, 6, 2)
hash[:six_month_low] = @new_high_lows.extract_high_low(page, 7, 2)
hash[:twelve_month_high] = @new_high_lows.extract_high_low(page, 8, 2)
hash[:twelve_month_low] = @new_high_lows.extract_high_low(page, 9, 2)
hash[:ytd_high] = @new_high_lows.extract_high_low(page, 10, 2)
hash[:ytd_low] = @new_high_lows.extract_high_low(page, 11, 2)
hash[:saved_on] = Time.now

@new_high_lows.high_low_data_insertion(hash)
