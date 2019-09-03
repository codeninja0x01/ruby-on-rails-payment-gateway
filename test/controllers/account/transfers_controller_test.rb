require 'test_helper'

class Account::TransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account_transfer = account_transfers(:one)
  end

  test "should get index" do
    get account_transfers_url
    assert_response :success
  end

  test "should get new" do
    get new_account_transfer_url
    assert_response :success
  end

  test "should create account_transfer" do
    assert_difference('Account::Transfer.count') do
      post account_transfers_url, params: { account_transfer: {  } }
    end

    assert_redirected_to account_transfer_url(Account::Transfer.last)
  end

  test "should show account_transfer" do
    get account_transfer_url(@account_transfer)
    assert_response :success
  end

  test "should get edit" do
    get edit_account_transfer_url(@account_transfer)
    assert_response :success
  end

  test "should update account_transfer" do
    patch account_transfer_url(@account_transfer), params: { account_transfer: {  } }
    assert_redirected_to account_transfer_url(@account_transfer)
  end

  test "should destroy account_transfer" do
    assert_difference('Account::Transfer.count', -1) do
      delete account_transfer_url(@account_transfer)
    end

    assert_redirected_to account_transfers_url
  end
end
