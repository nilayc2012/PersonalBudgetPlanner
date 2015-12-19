require 'test_helper'

class ExpenseDetailsControllerTest < ActionController::TestCase
  test "should get expenseadd" do
    get :expenseadd
    assert_response :success
  end

  test "should get expensefilling" do
    get :expensefilling
    assert_response :success
  end

end
