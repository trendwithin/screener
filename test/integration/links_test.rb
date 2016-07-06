require 'test_helper'

class LinksTest < ActionDispatch::IntegrationTest
  test 'navbar links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', zacks_path
    assert_select 'a[href=?]', briefings_path
    assert_select 'a[href=?]', daily_high_lows_path
    assert_select 'a[href=?]', new_highs_path
    assert_select 'a[href=?]', all_time_highs_path
  end
end
