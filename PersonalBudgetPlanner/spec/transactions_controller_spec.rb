require 'spec_helper'
require 'rails_helper'

describe TransactionsController, type: :controller do

  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  #Example 1
  #Action under test : get_by_amount
  it "should display error notification for empty to_amount entered" do

    params = {
      :famt => "20",
      :tamt => ""
    }

    post :get_by_amount , params

    expect(session[:amount_message]).to eq("None Of The Field Can be Blank")

    response.should redirect_to "where_i_came_from"
  end

  #Example 2
  #Action under test : get_by_amount
  it "should display error notification for  empty from_amount entered" do
    params = {
      :famt => "",
      :tamt => "20"
    }

    post :get_by_amount , params

    expect(session[:amount_message]).to eq("None Of The Field Can be Blank")
    response.should redirect_to "where_i_came_from"
  end

  #Example 3
  #Action under test : get_by_amount
  it "should display error notification for empty from_amount and to_amount entered" do
    params = {
      :famt => "",
      :tamt => ""
    }

    post :get_by_amount , params

    expect(session[:amount_message]).to eq("None Of The Field Can be Blank")
    response.should redirect_to "where_i_came_from"

  end

  #Example 4
  #Action under test : get_by_amount
  it "should display empty list when no amount is specified" do
    params = {
      :famt => "0",
      :tamt => "0"
    }
    session[ :uname ]="manoj12"
    post :get_by_amount ,params,session

    expect(session[:exp_list]).to be_empty

  end

  #Example 5
  #Action under test : get_by_amount
  it "should display an error notice when non numeric amount is entered" do
    params = {
      :famt => "hello",
      :tamt => "adsdg"
    }
    session[ :uname ]="manoj12"
    post :get_by_amount ,params,session

    expect(session[:amount_message]).to eq("Amount can only be number")

    response.should redirect_to "where_i_came_from"

  end

  #Example 6
  #Action under test : get_by_amount
  it "should display the list of transactions within the amount range given" do
    params = {
      :famt => "100",
      :tamt => "30000"
    }
    session[ :uname ]="manoj12"
    post :get_by_amount ,params,session

    expect(session[:exp_list]).not_to be_empty

  end

  #Example 7
  #Action under test : get_by_type
  it "should display empty list when no transactions are available for an expense type" do
    params = {
      :btype => "Food Expense"
    }

    session[ :uname ] = "manoj12"
    post :get_by_type ,params,session

    expect(session[:exp_list]).to be_empty

  end

  #Example 8
  #Action under test : get_by_type
  it "should display non empty list when  transactions are available for an expense type" do
    params = {
      :btype => "Rental Expense"
    }

    session[:uname] = "manoj12"
    post :get_by_type ,params,session

    expect(session[:exp_list]).not_to be_empty

  end

  #Example 9
  #Action under test : get_by_date
  it "should display non empty list when  transactions are available within the specified dates" do
    params = {
      # from 24-5-2015 to 26-5-2015
      :fdate => {:year => "2015",:month => "5", :day => "24"},
      :tdate => {:year => "2015",:month => "5", :day => "26"}
    }

    session[:uname] = "manoj12"
    post :get_by_date ,params,session

    expect(session[:exp_list]).not_to be_empty

  end

  #Example 10
  #Action under test : get_by_date
  it "should display empty list when  transactions are not available within the specified dates" do
    params = {
      # from 22-5-2015 to 23-5-2015
      :fdate => {:year => "2015",:month => "5", :day => "22"},
      :tdate => {:year => "2015",:month => "5", :day => "23"}
    }

    session[:uname] = "manoj12"
    post :get_by_date ,params,session

    expect(session[:exp_list]).to be_empty

  end

  #Example 11
  #Action under test : select_by_type
  it "should populate all distinct expense types for the current user" do

    session[:uname]="nilay"
    get :select_by_type,nil,session
    expect(session[:typeOptions].uniq.length).to eq(session[:typeOptions].length)
  end

end