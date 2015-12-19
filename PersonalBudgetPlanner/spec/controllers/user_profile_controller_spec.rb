require 'rails_helper'

describe UserProfileController, type: :controller do

  #Example 1
  #Action under test => home_page
  it "should fetch all Notifications from the database " do
    post :home_page
    expect(session[:all_notifications]).not_to be_empty
  end

  #Example 2
  #Action under test => home_page
  it "should get notifications count from the database " do
    post :home_page
    expect(session[:notifications_count]).not_to eq(0)
  end

  #Example 3
  #Action under test => home_page
  it "should generate type_options from the database " do
    session[ :uname ] = "manoj12"
    post :home_page,nil,session
    expect(session[:type_options]).not_to be_empty
  end

  #Example 4
  #Action under test => home_page
  it "should fetch the user details from the database " do
    session[ :uname ] = "manoj12"
    post :home_page,nil,session
    expect(session[:user_details]).not_to be_empty
  end
end

