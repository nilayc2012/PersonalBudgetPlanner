require 'spec_helper'
require 'rails_helper'

describe ExpenseDetailsController, type: :controller do

#setting the HTTP referer to go back to previous page
  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

 # display error when expense field type is empty
it "should display error notification for  expense type field  shouldnt be empty" do

    params = {
      :eamt => "1000",
      :edesc => "f",
      :expense_type => "",
      :date_prefix => {:year => "2015", :month => "7", :day => "12"},
    }
    post :add_expense, params
    expect(session[:emsg]).to eq("filled")
    response.should redirect_to "where_i_came_from"
  end

  #validating when user fill all the detatils then only successfully filled
  it "should redirect to Expense filling page with a success notice on successful save" do
    params = {
      :eamt => "2222",
      :edesc => "cash",
      :expense_type => "Medical Expense",
      :date_prefix => {:year => "2015", :month => "6", :day => "1"},
    }
    post :add_expense, params
    expect(session[:emsg]).to eq("filled")
    response.should redirect_to "where_i_came_from"
  end

 # validating when user fill all the detatils then only successfully filled
 it "should redirect to Expense filling page with a success notice on successful save" do
    params = {
      :eamt => "2000",
      :edesc => "cash",
      :expense_type => "Bus expnse",
      :date_prefix => {:year => "2015", :month => "5", :day => "30"},
    }
    post :add_expense, params
    expect(session[:emsg]).to eq("filled")
    response.should redirect_to "where_i_came_from"
  end
end