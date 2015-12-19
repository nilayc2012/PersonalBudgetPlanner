require 'spec_helper'
require 'rails_helper'

describe EditExpenseController, type: :controller do

  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  #Example 1
  #Subject code : Action =>  edit
  it "should fetch the expense ID of the transaction to be modified " do

    params = {
      :exp_id => '9',
    }
    session[:uname]="nilay"
    post :edit,params,session
    expect(session[:exp_id]).to eq(9)

  end

  #Example 2
  #Subject code : Action =>  edit
  it "should pool all expense details based on the fetched expense ID but not shared details if expense not shared " do

    params = {
      :exp_id => '9',
    }
    session[:uname]="nilay"
    post :edit,params,session
    expect(session[:exp_dets].nil?).to eq(false)
    expect(session[:share_dets]).to be_empty

  end

  #Example 3
  #Subject code : Action =>  edit
  it "should pool all expense and shared details based on the fetched expense ID if expense shared" do

    params = {
      :exp_id => '16',
    }
    session[:uname]="nilay"
    post :edit,params,session
    expect(session[:exp_dets].nil?).to eq(false)
    expect(session[:share_dets]).not_to be_empty

  end

  #Example 4
  #Subject code : Action =>  modify
  it "should give a error response for expense amount not entered" do

    post :modify
    expect(session[ :editmsg  ]).to eq("empty")
    response.should redirect_to "where_i_came_from"

  end

  #Example 5
  #Subject code : Action =>  modify
  it "should give a error response for expense type not entered" do

    params = {
      :eamt => '1600',
    }
    post :modify,params
    expect(session[ :editmsg  ]).to eq("empty type")
    response.should redirect_to "where_i_came_from"

  end

  #Example 6
  #Subject code : Action =>  modify
  it "should give a error response for invalid expense amount entered" do

    params = {
      :eamt => 'absc',
      :etype => 'Bus Expense'
    }
    post :modify,params
    expect(session[ :editmsg  ]).to eq("number")
    response.should redirect_to "where_i_came_from"

  end

  #Example 7
  #Subject code : Action =>  modify
  it "should update expense details with the values entered" do

    params = {
      :eamt => '10000',
      :edesc => 'cash now',
      :etype => 'Travel Expense',
      :date_prefix => {:year => "2013",:month => "5", :day => "26"}
    }
    session[:uname]="nilay"
    session[:exp_id] = '16'

    post :modify,params,session
    date_test = Date::civil( params[ :date_prefix ][ :year ].to_i, params[ :date_prefix ][ :month ].to_i, params[ :date_prefix ][ :day ].to_i )
    expect(session[:exp_dets].id).to eq(16)
    expect(session[:exp_dets].expense_amount).to eq(10000)
    expect(session[:exp_dets].expense_desc).to eq('cash now')
    expect(session[:exp_dets].expense_type).to eq('Travel Expense')
    expect(session[:exp_dets].expense_date).to eq(date_test)
    expect(session[:exp_dets].user_name).to eq("nilay")

  end

  #Example 8
  #Subject code : Action =>  modify
  it "should create a new shared expense entry if the username doesn't exist in shared expense table" do

    params = {
      :eamt => '10000',
      :edesc => 'cash now',
      :etype => 'Travel Expense',
      :date_prefix => {:year => "2013",:month => "5", :day => "26"}
    }
    session[:uname]="nilay"
    session[:exp_id] = '9'

    post :modify,params,session
    expect(session[:sh_exp].user_name).to eq("nilay")
    expect(session[:sh_exp].expense_id).to eq(9)

  end

  #Example 9
  #Subject code : Action =>  modify
  it "should update the expense details to shared details table and should share to changed new user" do

    params = {
      :eamt => '10000',
      :edesc => 'cash now',
      :etype => 'Travel Expense',
      :date_prefix => {:year => "2013",:month => "5", :day => "26"},
      :shuser => 'vikram12'
    }
    session[:uname]="nilay"
    session[:exp_id] = '15'

    post :modify,params,session
    expect(session[:sh_exp].user_name).to eq("nilay")
    expect(session[:sh_exp].expense_id).to eq(15)
    expect(session[:sh_exp].expense_type ).to eq('Travel Expense')
    expect(session[:sh_exp].expense_amount).to eq(10000)
    expect(session[:sh_exp].expense_desc).to eq('cash now')
    expect(session[:sh_exp].shared_user_name).to eq('vikram12')
    expect(session[ :editmsg  ]).to eq("filled")
    response.should redirect_to "where_i_came_from"

  end

  #Example 10
  #Subject code : Action =>  modify
  it "should pool update the expense details to shared details table and should share to changed new user and should redirect with a success message" do

    params = {
      :exp_id => '9',
    }
    session[:uname]="nilay"
    session[:my_previous_url] = ""

    post :delete,params,session

    expect(session[ :dmsg  ]).to eq("deleted")

  end

end