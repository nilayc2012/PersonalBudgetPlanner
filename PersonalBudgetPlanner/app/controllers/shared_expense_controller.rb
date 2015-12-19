class SharedExpenseController < ApplicationController
  #this method is used to fetch the shared expense details from database and send them back to view
  def share_expense
    @shared_expense = SharedExpense.where( shared_user_name: session[ :uname ] )
    session[:shared_expense]=@shared_expense
  end
end
