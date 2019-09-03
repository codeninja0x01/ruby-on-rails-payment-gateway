require 'test_helper'

class BalanceCard::FundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @balance_card_fund = balance_card_funds(:one)
  end

  test "should get index" do
    get balance_card_funds_url
    assert_response :success
  end

  test "should get new" do
    get new_balance_card_fund_url
    assert_response :success
  end

  test "should create balance_card_fund" do
    assert_difference('BalanceCard::Fund.count') do
      post balance_card_funds_url, params: { balance_card_fund: {  } }
    end

    assert_redirected_to balance_card_fund_url(BalanceCard::Fund.last)
  end

  test "should show balance_card_fund" do
    get balance_card_fund_url(@balance_card_fund)
    assert_response :success
  end

  test "should get edit" do
    get edit_balance_card_fund_url(@balance_card_fund)
    assert_response :success
  end

  test "should update balance_card_fund" do
    patch balance_card_fund_url(@balance_card_fund), params: { balance_card_fund: {  } }
    assert_redirected_to balance_card_fund_url(@balance_card_fund)
  end

  test "should destroy balance_card_fund" do
    assert_difference('BalanceCard::Fund.count', -1) do
      delete balance_card_fund_url(@balance_card_fund)
    end

    assert_redirected_to balance_card_funds_url
  end
end
