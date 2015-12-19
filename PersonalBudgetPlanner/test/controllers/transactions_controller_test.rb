require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  test "should get bydate" do
    get :bydate
    assert_response :success
  end

  test "should get bytype" do
    get :bytype
    assert_response :success
  end

  test "should get byamount" do
    get :byamount
    assert_response :success
  end

end
