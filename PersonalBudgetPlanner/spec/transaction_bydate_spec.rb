require 'rails_helper'
describe TransactionsController do
  #example!
  it "page should be 200" do
    lambda do
      visit '/transactions/get_by_date'
      except(response).to be(200)
      session[ :uname ] = "vikram"
      get :get_by_date, session[ :uname ], :expense=>{:from_date=>"2013-08-05 00:0:00", :to_date =>"2015-08-05 00:0:00" }
      expect(page).to have_text("barchart")
      expect(page).to have_text("piechart")
      expect(@expense_list.count).not_to be_empty
    end
  end
end