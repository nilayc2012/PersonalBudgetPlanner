require 'test_helper'

class UserLoginControllerTest < ActionController::TestCase
  test "should get match" do
    get :match
    assert_response :success
  end

end
