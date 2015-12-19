require 'spec_helper'
require 'rails_helper'

describe UserLoginController, type: :controller do

#setting the HTTP referer to go back to previous page
  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  #Example 1
  it "should redirect to main page with a failure notice as not username not existing" do
    params = {
      :uname => "vikram",
      :pwd => "123456"
    }
    post :auth_user, params
    expect(session[:message]).to eq("User doesn't exist")
    response.should redirect_to "where_i_came_from"
  end

  #Example 2
  it "should redirect to main page with a failure notice as wrong password" do
    params = {
      :uname => 'vikram1',
      :pwd => '12345'
    }
    post :auth_user, params
    expect(session[:message]).to eq("wrong password")
    response.should redirect_to "where_i_came_from"
  end

  #Example 3
  it "should redirect to expense filling page after successful login" do
    params = {
      :uname => "vikram1",
      :pwd => "123456",
    }
    post :auth_user, params
    expect(session[:uname]).to eq(params[:uname])
  end
   #Change password 
   #Example 1
  it "should redirect to main page with a failure notice for Current password incorrect" do
    params = {
      :currentpwd => "hello0",
      :newpwd=> "123" ,
      :confirmnewpwd => "123"
    }

    post :change_pwd, params
    expect(session[:msg]).to eq("incorrect")
    response.should redirect_to "where_i_came_from"
  end

  #Example2
  it "should redirect to main page with a failure notice for password don't match" do
    params = {
      :currentpwd => "123456",
      :newpwd=> "123456" ,
      :confirmnewpwd => "1234"
    }
    post :change_pwd, params
    expect(session[:msg]).to eq("not match")
    response.should redirect_to "where_i_came_from"
  end

end