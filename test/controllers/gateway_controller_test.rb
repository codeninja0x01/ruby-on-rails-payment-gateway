require 'test_helper'

class GatewayControllerTest < ActionDispatch::IntegrationTest
  test "should get initializer" do
    get gateway_initializer_url
    assert_response :success
  end

end
