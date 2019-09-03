require 'test_helper'

class Auth::PasswordRestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auth_password_rest = auth_password_rests(:one)
  end

  test "should get index" do
    get auth_password_rests_url
    assert_response :success
  end

  test "should get new" do
    get new_auth_password_rest_url
    assert_response :success
  end

  test "should create auth_password_rest" do
    assert_difference('Auth::PasswordRest.count') do
      post auth_password_rests_url, params: { auth_password_rest: {  } }
    end

    assert_redirected_to auth_password_rest_url(Auth::PasswordRest.last)
  end

  test "should show auth_password_rest" do
    get auth_password_rest_url(@auth_password_rest)
    assert_response :success
  end

  test "should get edit" do
    get edit_auth_password_rest_url(@auth_password_rest)
    assert_response :success
  end

  test "should update auth_password_rest" do
    patch auth_password_rest_url(@auth_password_rest), params: { auth_password_rest: {  } }
    assert_redirected_to auth_password_rest_url(@auth_password_rest)
  end

  test "should destroy auth_password_rest" do
    assert_difference('Auth::PasswordRest.count', -1) do
      delete auth_password_rest_url(@auth_password_rest)
    end

    assert_redirected_to auth_password_rests_url
  end
end
