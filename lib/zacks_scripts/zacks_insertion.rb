require_relative 'fetch_zacks'

@zacks_earnings = FetchZacks::ZacksParser.new
url = 'https://www.zacks.com/research/earnings/earning_export.php'
@zacks_earnings.fetch_xls_file(url)
@zacks_earnings.insert_zacks_data
