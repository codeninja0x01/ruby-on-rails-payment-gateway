require 'test_helper'

class Account::FundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account_fund = account_funds(:one)
  end

  test "should get index" do
    get account_funds_url
    assert_response :success
  end

  test "should get new" do
    get new_account_fund_url
    assert_response :success
  end

  test "should create account_fund" do
    assert_difference('Account::Fund.count') do
      post account_funds_url, params: { account_fund: {  } }
    end

    assert_redirected_to account_fund_url(Account::Fund.last)
  end

  test "should show account_fund" do
    get account_fund_url(@account_fund)
    assert_response :success
  end

  test "should get edit" do
    get edit_account_fund_url(@account_fund)
    assert_response :success
  end

  test "should update account_fund" do
    patch account_fund_url(@account_fund), params: { account_fund: {  } }
    assert_redirected_to account_fund_url(@account_fund)
  end

  test "should destroy account_fund" do
    assert_difference('Account::Fund.count', -1) do
      delete account_fund_url(@account_fund)
    end

    assert_redirected_to account_funds_url
  end
end
