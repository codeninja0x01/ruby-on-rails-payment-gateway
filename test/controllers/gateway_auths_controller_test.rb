require 'test_helper'

class GatewayAuthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gateway_auth = gateway_auths(:one)
  end

  test "should get index" do
    get gateway_auths_url
    assert_response :success
  end

  test "should get new" do
    get new_gateway_auth_url
    assert_response :success
  end

  test "should create gateway_auth" do
    assert_difference('GatewayAuth.count') do
      post gateway_auths_url, params: { gateway_auth: { title: @gateway_auth.title } }
    end

    assert_redirected_to gateway_auth_url(GatewayAuth.last)
  end

  test "should show gateway_auth" do
    get gateway_auth_url(@gateway_auth)
    assert_response :success
  end

  test "should get edit" do
    get edit_gateway_auth_url(@gateway_auth)
    assert_response :success
  end

  test "should update gateway_auth" do
    patch gateway_auth_url(@gateway_auth), params: { gateway_auth: { title: @gateway_auth.title } }
    assert_redirected_to gateway_auth_url(@gateway_auth)
  end

  test "should destroy gateway_auth" do
    assert_difference('GatewayAuth.count', -1) do
      delete gateway_auth_url(@gateway_auth)
    end

    assert_redirected_to gateway_auths_url
  end
end
