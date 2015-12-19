require 'spec_helper'
require 'rails_helper'

describe AddnotificationController, type: :controller do

  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  it "should tell reminder added successfully " do

    params = {
      :reminder => "yes to matter1",
      :date_prefix => {:year => "2015", :month => "6", :day => "29"}
    }
       post :add, params
    expect(session[:emsg]).to eq("filled")
   end

  end