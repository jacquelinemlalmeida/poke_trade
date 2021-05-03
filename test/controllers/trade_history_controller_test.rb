require "test_helper"

class TradeHistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get trade_history_show_url
    assert_response :success
  end
end
