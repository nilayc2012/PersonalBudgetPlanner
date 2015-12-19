class EditExpenseController < ApplicationController
=begin
The modify action updates/modifies the database with new transaction details
=end
  def edit
    if session[:exp_id].nil?
      @expense_details = Expense.find(params[:exp_id].to_i)
      @shared_user = SharedExpense.find_by_sql("SELECT SHARED_USER_NAME FROM SHARED_EXPENSES WHERE EXPENSE_ID = '#{params[:exp_id].to_i}'").map(&:shared_user_name)
      session[:exp_id] = params[:exp_id].to_i
      session[:exp_dets] = @expense_details
      session[:share_dets] = @shared_user
    else
      @expense_details = Expense.find(session[:exp_id].to_i)
      @shared_user = SharedExpense.find_by_sql("SELECT SHARED_USER_NAME FROM SHARED_EXPENSES WHERE EXPENSE_ID = '#{session[:exp_id].to_i}'").map(&:shared_user_name)
      session[:exp_dets] = @expense_details
      session[:share_dets] = @shared_user
    end
    @users = UserDetail.select( :user_name ).where.not( :user_name => session[ :uname ]).map(&:user_name)
    session[:usr] = @users
  end
=begin
The modify action updates/modifies the database with new transaction details
=end
  def modify
    if params[ :eamt ].blank?
      session[ :editmsg  ] = "empty"
      redirect_to :back
    elsif params[ :etype ].blank?
      session[ :editmsg  ] = "empty type"
      redirect_to :back
    else
      if params[ :eamt ].to_i == 0
        session[ :editmsg  ] = "number"
        redirect_to :back
      else
        @expense_details = Expense.find(session[:exp_id].to_i)
        @expense_details.expense_amount = params[ :eamt ]
        @expense_details.expense_desc = params[ :edesc ]
        @expense_details.expense_type = params[ :etype ]
        @expense_details.expense_date = Date::civil(params[ :date_prefix ][ :year ].to_i, params[ :date_prefix ][ :month ].to_i, params[ :date_prefix ][ :day ].to_i)
        @expense_details.save
        session[:exp_dets] = @expense_details
        shared_expense = SharedExpense.find_by_expense_id( session[:exp_id].to_i)
        if shared_expense.nil?
          shared_expense = SharedExpense.new
          shared_expense.user_name = session[ :uname ]
          shared_expense.expense_id = @expense_details.id
        end
        if params[:shuser].blank?
          shared_expense.destroy
        else
          shared_expense.expense_type = params[ :etype ]
          shared_expense.expense_amount = params[ :eamt ]
          shared_expense.expense_date = Date::civil(params[ :date_prefix ][ :year ].to_i, params[ :date_prefix ][ :month ].to_i, params[ :date_prefix ][ :day ].to_i)
          shared_expense.expense_desc = params[ :edesc ]
          shared_expense.shared_user_name = params[:shuser]
          shared_expense.save
        end
        session[:sh_exp] = shared_expense
        session[ :editmsg  ]="filled"
        redirect_to :back
      end
    end
  end
=begin
The delete action deletes the transaction from the database
=end
  def delete
    Expense.find(params[:exp_id].to_i).destroy
    @shared_user = SharedExpense.find_by_expense_id( params[:exp_id].to_i)
    if !@shared_user.nil?
      @shared_user.destroy
    end
    session[ :dmsg] = "deleted"
    session[:my_previous_url] = URI(request.referer).path
    if session[:my_previous_url].include? "amount"
      redirect_to '/transactions/select_by_amount.html'
    elsif session[:my_previous_url].include? "date"
      redirect_to '/transactions/select_by_date.html'
    elsif session[:my_previous_url].include? "type"
      redirect_to '/transactions/select_by_type.html'
    else
      redirect_to :back
    end
  end


end
