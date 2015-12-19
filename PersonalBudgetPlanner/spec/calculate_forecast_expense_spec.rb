require 'spec_helper'
require 'rails_helper'

describe UserProfileController, type: :controller do

  it "page should display Forecast Expense Details" do
    lambda do
      visit '/user_profile/calculate_forecost_expense'
      except(page).to be(200)
      session[ :uname ] = "vikram"
      get :calculate_forecost_expense, session[ :uname ], :expense=>{"from_date(1i)"=>"2015", "from_date(2i)"=>"7", "from_date(3i)"=>"18", "to_date(1i)"=>"2015", "to_date(2i)"=>"7", "to_date(3i)"=>"18"}
      expect(session[:uname]).not_to be_empty
      expect(@display_only_three_records.count).to eq(3)
      expect(@expense_result.count).not_to be_empty
    end
  end

#example2
it "page should display Forecast Expense Details" do
    lambda do
      visit '/user_profile/calculate_forecost_expense'
      except(page).to be(200)
      session[ :uname ] = "vikram"
      get :calculate_forecost_expense, session[ :uname ], :expense=>(params[:expense][:expense_type])
      expect(session[ :uname]).not_to be_empty
      expect(@display_only_three_records.count).to eq(3)
      expect(@expense_result.count).not_to be_empty
    end
  end


end