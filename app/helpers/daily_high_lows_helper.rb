module DailyHighLowsHelper

  def high_low_chart
    diff_data = []
    @daily_difference.columns.each_with_index do |category_name, index|
      category_data = {}
      @daily_difference.rows.each do |raw_data_row|
        category_data[raw_data_row[5]] = raw_data_row[index] unless index == 5
      end
      unless category_name == 'saved_on'
        diff_data << { name: category_name, data:  category_data }
      end
    end
  line_chart diff_data
  end
end
