class TransactionsController < ApplicationController
=begin
Method - bydate
This method fetches the start_date and end_date from the
view and queries the database to fetch
the transactions within the range
=end
  def get_by_date
    @type_options = Expense.select( :expense_type ).where( :user_name => session[ :uname ]).map(&:expense_type).uniq
    session[:type_options] = @type_options 
    from_date = Date::civil( params[ :fdate ][ :year ].to_i, params[ :fdate ][ :month ].to_i, params[ :fdate ][ :day ].to_i )
    to_date = Date::civil( params[ :tdate ][ :year ].to_i, params[ :tdate ][ :month ].to_i, params[ :tdate ][ :day ].to_i )
    user_expense=Expense.where(user_name: session[ :uname])
    @expense_list = user_expense.where("expense_date >= :start_date AND expense_date <= :end_date AND user_name = :user", {start_date: from_date, end_date: to_date, user: session[ :uname ]})
    collect_all_type={}; merge_duplicate_type={}
    @expense_list.map {|expense| !collect_all_type.key?(expense.expense_type) ? (collect_all_type[expense.expense_type] = [expense.expense_amount.to_i]):
    (collect_all_type[expense.expense_type] << expense.expense_amount.to_i)}
    collect_all_type.map {|collect_expense| merge_duplicate_type[collect_expense[0]] = (collect_expense[1].count == 1 ? (collect_expense[1].first):
    ((collect_expense[1].sum)))}
    gon.expense_list=(merge_duplicate_type.sort_by {|k, v| v}.reverse)
  end
=begin
Method - bytype
This method fetches the type of the expense from the
view and queries the database to fetch the transactions of that type
=end
  def get_by_type
    @expense_list = Expense.where(expense_type: params[ :btype ],user_name: session[:uname])
    session[:exp_list] = @expense_list
    gon.expense_list=@expense_list.collect {|expense| {:name=>expense.expense_type,:y=>Expense.where(:expense_type=>expense.expense_type).count,:drilldown=>expense.expense_type}}.uniq
  end

=begin
Method - byamount
This method fetches the range of amount from the view and
queries the database to fetch the transactions within the amount range
=end
  def get_by_amount 

    if params[ :famt ].blank? || params[ :tamt ].blank?
      session[ :amount_message ] = "None Of The Field Can be Blank"
      redirect_to :back
    else
      begin
      !!Integer(params[ :famt ])
        !!Integer(params[ :tamt ])
        @expense_list = Expense.where("expense_amount >= :start_amt AND expense_amount <= :end_amt AND user_name = :user", {start_amt: params[ :famt ], end_amt: params[ :tamt ], user: session[ :uname ]})
        session[:exp_list] = @expense_list
      rescue ArgumentError, TypeError
        session[ :amount_message ] = "Amount can only be number"
        redirect_to :back
      end
    end
  end

  def select_by_type
    @type_options = Expense.select( :expense_type ).where( :user_name => session[ :uname ]).map(&:expense_type).uniq
    session[:typeOptions] = @type_options
  end
end
