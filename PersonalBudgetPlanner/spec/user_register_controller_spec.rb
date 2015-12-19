require 'spec_helper'
require 'rails_helper'

describe UserRegisterController, type: :controller do

#setting the HTTP referer to go back to previous page
  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end


  #Example 1
  it "should redirect to main page with a failure notice for password don't match" do
    params = {
      :uname => "vikram",
      :pwd => "1234",
      :cpwd => "123456"
    }
    post :add_user, params
    expect(session[:msg]).to eq("filled")
    response.should redirect_to "where_i_came_from"
  end
 #Example 2
  it "should redirect to main page with a success notice for register successfully" do
    params = {
      :uname => "vikram",
      :pwd => "123456",
      :cpwd => "123456"
    }
    post :add_user, params
    expect(session[:msg]).to eq("filled")
    response.should redirect_to "where_i_came_from"
  end
 #Example3
  it "should redirect to main page with a failure notice user already exist" do
    params = {
      :uname => "vikram11",
      :pwd => "12345",
      :cpwd => "12345"
    }
    post :add_user, params
    expect(session[:msg]).to eq("existing")
    response.should redirect_to "where_i_came_from"
  end

end