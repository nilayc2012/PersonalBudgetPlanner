require 'spec_helper'
require 'rails_helper'

describe SharedExpenseController, type: :controller do
#Example to check if shared data is populated or not
  it "should populate all shared expense details to the current user" do

    session[:uname] = "manoj12"
    post :share_expense,nil,session
    expect(session[:shared_expense]).not_to be_empty

  end

end