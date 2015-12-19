require 'spec_helper'
require 'rails_helper'

describe NotificationsController, type: :controller do

  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  it "should tell reminder added successfully " do

    params = {
      :reminder => "yes to matter1",
      :date_prefix => {:year => "2015", :month => "6", :day => "03"}

    }
       post :create, params

    expect(session[:emsg]).to eq("filled")
   end

   it "should fetch the expense ID of the transaction to be modified " do

    params = {
      :reminder => "fill the time"
    }

    session[:notid]="105"

    post :modify,params,session
    expect(session[:emsg]).to eq("filled")

  end

  end