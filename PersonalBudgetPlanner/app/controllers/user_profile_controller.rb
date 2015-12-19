require 'date'

class UserProfileController < ApplicationController
  include UserProfileHelper
  def home_page
    @notification_strings =  Notifications.select(:notify_string).where(date1:Date.today.to_s).limit(3).map(&:notify_string)
    count=0
     @notification_strings.each do |notific|
        if notific.include? Date.today.to_s
           count=count+1
       end
    end
    @notifications =  Notifications.select(:notify_string).where(date1:Date.today.to_s).map(&:notify_string)
    session[:all_notifications] = @notifications 
    @notifications_count =  0
    @notifications.each do |n|
    @notifications_count = @notifications_count+1
    end
    session[:notifications_count] = @notifications_count 
    @type_options = Expense.select( :expense_type ).where( :user_name => session[ :uname ]).map(&:expense_type).uniq
    session[:type_options] = @type_options 
    @user_details = UserDetail.find_by user_name: session[ :uname ]
    session[:user_details] = @user_details  
  end

  def calculate_forecast_expense
    @expense=Expense.new #to have the form for expsnese so can use the expense type as text field
    user_expense=Expense.where(user_name: session[ :uname])
    calculate_forecast(user_expense)
    if !params[:expense].blank?
      if params[:expense][:expense_type].blank?
        exp=user_expense.where("created_at <= ?", user_search_params) #in this calling user_search_params method
        if !exp.blank?
          expense_type_search(exp,(user_search_params.to_date + 1.month).strftime("%B"))
        end
      elsif !Expense.where(user_name: session[ :uname],expense_type:params[:expense][:expense_type]).blank?
          date_based_search
      else
          redirect_to :action => "calculate_forecast_expense"
          session[:msg] = "Not Match"
      end
    end
  end

def user_search_params
  # need to be like this  from_date = "year-month-date time"("2015-07-18 00:00:00")
  date=params[:expense]
  from_date="#{date['from_date(1i)']}-#{date['from_date(2i)'].to_i-1}-#{date['from_date(3i)']}".to_time.strftime("%Y-%m-%d 11:59:00")
  end
end
