class ExpenseDetailsController < ApplicationController
  #This method is to add the expense details to the database
  def add_expense
    expense=Expense.new( 
      expense_type: params[:expense][:expense_type],
      expense_amount: params[ :eamt ],
      expense_date: Date::civil(params[ :date_prefix ][ :year ].to_i, params[ :date_prefix ][ :month ].to_i, params[ :date_prefix ][ :day ].to_i),
      expense_desc: params[ :edesc ],
      user_name: session[ :uname ]
      )
    expense.save
    @shared_user_name = params[ :shuser ]
    #check if shared user value is entered 
    if !@shared_user_name.nil?
      #fill the expense detail to table for shared expenses
      shared_expense = SharedExpense.new(
      expense_id: expense.id,
      expense_type: expense.expense_type,
      expense_amount: expense.expense_amount,
      expense_date: expense.expense_date,
      expense_desc: expense.expense_desc,
      user_name: session[ :uname ],
      shared_user_name: @shared_user_name       
      )
      shared_expense.save
    end
      #send a success message to display in view 
      session[ :emsg ]="filled"
      redirect_to :back   
  end
  
    #this method is used to send all the expense type options to the view which will be displayed as a select list
    def fill_expense
      @expense=Expense.new
      @users = UserDetail.select( :user_name ).where.not( :user_name => session[ :uname ]).map(&:user_name)
      @expense_types = Expense.select( :expense_type ).map(&:expense_type).uniq
      session[:user]=@users 
    end 
end
