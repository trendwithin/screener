module DailyHighLowsHelper

  def high_low_chart
    results = DailyHighLow.diff
    diff_data = []
    results.columns.each_with_index do |category_name, index|
      category_data = {}
      results.rows.each do |raw_data_row|
        category_data[raw_data_row[5]] = raw_data_row[index] unless index == 5
      end
      unless category_name == 'saved_on'
        diff_data << { name: category_name, data:  category_data }
      end
    end
  line_chart diff_data
  end
end
