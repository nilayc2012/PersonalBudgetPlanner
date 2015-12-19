require 'spec_helper'
require 'rails_helper'

describe ExpenseDetailsController, type: :controller do

#setting the HTTP referer to go back to previous page
  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  #Example 1
  it "should successfully add Expense details for the current user to shared expense details in database" do
    params = {
      :eamt => "1000",
      :edesc => "f",
      :expense_type => "restorent",
      :date_prefix => {:year => "2015", :month => "7", :day => "12"},
      :shuser => ""
    }
    session[:uname]="v"
    expect{post :add_expense, params,session}.to change{SharedExpense.count}.by(1)
  end

  #Example 2
  it "should populate all user names other than the current user" do

    session[:uname]="v"
    get :fill_expense,nil,session
    expect(session[:user].include? 'v').to eq(false)
  end

  #Example 3
  it "should redirect to Expense filling page with a error notice on non numeric expense amount entry" do
    params = {
      :eamt => "1000",
      :edesc => "f",
      :expense_type => "restorent",
      :date_prefix => {:year => "2015", :month => "7", :day => "12"},
    }
    post :add_expense, params
    expect(session[:emsg]).to eq("filled")
    response.should redirect_to "where_i_came_from"
  end
#example 4
  it "is invalid without expense amount" do
    expense=Expense.new
    expect { expense.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
  #example5
  it "is valid with expense amount" do
    expense=Expense.new(expense_amount: "2000")
    expense.should be_valid
  end

end