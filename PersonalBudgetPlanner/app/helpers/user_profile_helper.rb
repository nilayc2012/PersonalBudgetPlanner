module UserProfileHelper
  #collecting all the expense type with respective amount and merging all duplicate expense types
  def calculate_forecast(user_expense)
    collect_all_type={}; merge_duplicate_type={}
    user_expense.where("created_at <= ?", (Time.now).strftime("%Y-%m-%d 00::00:00")).map {|expense| !collect_all_type.key?(expense.expense_type) ? (collect_all_type[expense.expense_type] = [expense.expense_amount.to_i]):(collect_all_type[expense.expense_type] << expense.expense_amount.to_i)}
    collect_all_type.map {|collect_expense| merge_duplicate_type[collect_expense[0]] = (collect_expense[1].count == 1 ? (collect_expense[1].first):((collect_expense[1].sum)/(collect_expense[1].count)))}
    @display_only_three_records=(merge_duplicate_type.sort_by {|k, v| v}.reverse).first(3)
  end
  #based on Month collecting all expense type with respective amounts and merging duplicates
  def expense_type_search(exp,month)
    collect_all_expense_type= {}; merge_all_into_specific ={}
    exp.map {|expense| !collect_all_expense_type.key?(expense.expense_type) ? (collect_all_expense_type[expense.expense_type] = [expense.expense_amount.to_i]):(collect_all_expense_type[expense.expense_type] << expense.expense_amount.to_i)}
    collect_all_expense_type.map {|expense| merge_all_into_specific[expense[0]] = (expense[1].count == 1 ? (expense[1].first):((expense[1].sum)/(expense[1].count)))} if !exp.blank?
    @expense_result=merge_all_into_specific.merge!({:month=>month})
  end
 
  #based on Expense type collecting expense amounts
  def date_based_search
    date_based_collection = {}
    amount=Expense.where(user_name: session[ :uname],expense_type:params[:expense][:expense_type]).collect{|exp| exp.expense_amount.to_i}
    (date_based_collection[params[:expense][:expense_type]] = (amount.sum/amount.count))
    @expense_result=date_based_collection
  end
end
