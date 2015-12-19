require 'test_helper'

class SharedUserControllerTest < ActionController::TestCase
  test "should get shareduser" do
    get :shareduser
    assert_response :success
  end

end
