require 'test_helper'

class Accounts::BanksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @accounts_bank = accounts_banks(:one)
  end

  test "should get index" do
    get accounts_banks_url
    assert_response :success
  end

  test "should get new" do
    get new_accounts_bank_url
    assert_response :success
  end

  test "should create accounts_bank" do
    assert_difference('Accounts::Bank.count') do
      post accounts_banks_url, params: { accounts_bank: {  } }
    end

    assert_redirected_to accounts_bank_url(Accounts::Bank.last)
  end

  test "should show accounts_bank" do
    get accounts_bank_url(@accounts_bank)
    assert_response :success
  end

  test "should get edit" do
    get edit_accounts_bank_url(@accounts_bank)
    assert_response :success
  end

  test "should update accounts_bank" do
    patch accounts_bank_url(@accounts_bank), params: { accounts_bank: {  } }
    assert_redirected_to accounts_bank_url(@accounts_bank)
  end

  test "should destroy accounts_bank" do
    assert_difference('Accounts::Bank.count', -1) do
      delete accounts_bank_url(@accounts_bank)
    end

    assert_redirected_to accounts_banks_url
  end
end
