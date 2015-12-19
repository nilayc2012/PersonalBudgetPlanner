require 'spec_helper'
require 'rails_helper'

describe EditNotificationController, type: :controller do

  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  #Example 1
  #Subject code : Action =>  edit
   it "should fetch the expense ID of the transaction to be modified " do

    params = {
      :reminder => "fill the time"
    }

    session[:notid]="23"

    post :modify,params,session
    expect(session[:emsg]).to eq("filled")

  end
  end