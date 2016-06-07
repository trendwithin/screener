require_relative '../lib/barchart_high_low'

require 'byebug'
@new_high_lows = Barchart::HighLow.new
url = 'http://www.barchart.com/stocks/newhilo.php?dwm=d'
html_tag = "div[id='divContent']"
hash = Hash.new(0)
page = @new_high_lows.pager(url, html_tag)

hash[:one_month_high] = @new_high_lows.one_month_high(page)
hash[:one_month_low] = @new_high_lows.one_month_low(page)
hash[:three_month_high] = @new_high_lows.three_month_high(page)
hash[:three_month_low] = @new_high_lows.three_month_low(page)
hash[:six_month_high] = @new_high_lows.six_month_high(page)
hash[:six_month_low] = @new_high_lows.six_month_low(page)
hash[:twelve_month_high] = @new_high_lows.twelve_month_high(page)
hash[:twelve_month_low] = @new_high_lows.twelve_month_low(page)
hash[:ytd_high] = @new_high_lows.ytd_month_high(page)
hash[:ytd_low] = @new_high_lows.ytd_month_low(page)
hash[:saved_on] = Time.now

@new_high_lows.high_low_data_insertion(hash)
