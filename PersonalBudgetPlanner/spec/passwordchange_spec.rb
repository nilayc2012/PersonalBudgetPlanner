require 'spec_helper'
require 'rails_helper'

describe UserpasswordchangeController , type: :controller do

#setting the HTTP referer to go back to previous page
  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  #Example 1
  it "should redirect to main page with a failure notice for Current password incorrect" do

     params = {
      :currentpwd => "1234567",
      :newpwd=> "54321" ,
      :confirmnewpwd => "54321"
    }
    post :change_pwd, params
    expect(session[:msg]).to eq("incorrect")
    response.should redirect_to "where_i_came_from"
  end
  #Example2
   it "should redirect to main page with a failure notice for password don't match" do

     params = {
      :currentpwd => "hello",
      :newpwd=> "4321" ,
      :confirmnewpwd => "54321"
    }
    post :change_pwd, params
    expect(session[:msg]).to eq("incorrect")
    response.should redirect_to "where_i_came_from"
  end
end
 