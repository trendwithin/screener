class DailyHighLow < ActiveRecord::Base

  private
  def self.reduce_highs(highs, lows)
    highs.zip(lows).map { |h, l| h - l }
  end

  def self.high_low_difference
    sql = "SELECT one_month_high - one_month_low as one_month,
           three_month_high - three_month_low as three_month,
           six_month_high - six_month_low as six_month,
           twelve_month_high - twelve_month_low as twelve_month,
           ytd_high - ytd_low as ytd,
           saved_on
           FROM daily_high_lows
           ORDER BY saved_on DESC;"
    records = ActiveRecord::Base.connection.exec_query(sql)
  end

  def self.high_low_difference_json
  sql = "WITH seqs AS (
         SELECT  json_object_agg(saved_on::text, one_month_high ORDER BY saved_on) one_month_highs,
         json_object_agg(saved_on::text, one_month_low ORDER BY saved_on) one_month_lows
         FROM    daily_high_lows)
         SELECT  json_agg(j)
         FROM    (
         SELECT json_build_object('name', 'One Month Highs', 'data', one_month_highs)
         FROM   seqs
         UNION ALL
         SELECT json_build_object('name', 'One Month Lows', 'data', one_month_lows)
         FROM seqs
         ) x(j)
         ;"
  records = ActiveRecord::Base.connection.exec_query(sql)
  end
end
